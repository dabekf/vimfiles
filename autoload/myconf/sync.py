#!/usr/bin/python
# -*- coding: UTF-8 -*-
import sys
import re
import os
import subprocess
from pprint import pprint
assert pprint

scp_command = ("rsync",)
debug = False

projects = {
	'to5': {
		'source': r'^.+/Projects/(redNet/)?([a-z0-9]+)\.to5\.tabelaofert\.pl', # regular expression
		'destination': {
			'test': {
				'directory': r'/home/www/\2.to5.tabelaofert.pl', # regular replacement
				'hosts': ['fdabek@inzynier'],
			},
			'production': {
				'directory': r'/home/www/to5.tabelaofert.pl',
				'hosts': ['fdabek@flap', 'fdabek@flip', 'fdabek@aragon'],
				# 'hosts': ['fdabek@aragon'],
			},
		}
	},
	'importer': {
		'source': r'^.+/Projects/(redNet/)?importer\.tabelaofert\.pl',
		'destination': {
			'test': {
				'directory': r'/home/www/importer.tabelaofert.pl',
				'hosts': ['fdabek@inzynier'],
			},
			'production': {
				'directory': r'/home/www/importer.tabelaofert.pl',
				'hosts': ['fdabek@aragon'],
			},
		}
	},
	'optimage': {
		'source': r'^.+/Projects/(redNet/)?([a-z0-9]+)\.optimage',
		'destination': {
			'test': {
				'directory': r'/home/www/\2.optimage',
				'hosts': ['fdabek@inzynier'],
			},
			'production': {
				'directory': r'/home/www/optimage',
				'hosts': ['fdabek@zielony'],
			},
		}
	},
	'polskikoszyk': {
		'source': r'^.+/Projects/(redNet/)?([a-z0-9]+)\.polskikoszyk\.pl', # regular expression
		'destination': {
			'test': {
				'directory': r'/home/www/\1.polskikoszyk.pl', # regular replacement
				'hosts': ['fdabek@inzynier'],
			},
			'production': {
				'directory': r'/home/www/polskikoszyk.pl',
				'hosts': ['fdabek@zielony'],
			},
		}
	},
	'content': {
		'source': r'^.+/Projects/(redNet/)?content\.tabelaofert\.pl',
		'destination': {
			'test': {
				'directory': r'/home/www/content.tabelaofert.pl',
				'hosts': ['fdabek@inzynier'],
			},
			'production': {
				'directory': r'/home/www/content.tabelaofert.pl',
				'hosts': ['fdabek@aragon'],
			},
		}
	},
	'crm': {
		'source': r'^.+/Projects/(redNet/)?crm\.rednet\.pl',
		'destination': {
			'test': {
				'directory': r'/home/www/crm',
				'hosts': ['fdabek@inzynier'],
			},
		}
	},
	'thebuggenie': {
		'source': r'^.+/Projects/thebuggenie',
		'destination': {
			'test': {
				'directory': r'/home/www/bug.rednetproperty.com',
				'hosts': ['fdabek@inzynier'],
			},
			'production': {
				'directory': r'/home/www/bug.rednetproperty.com',
				'hosts': ['fdabek@aragon'],
			},
		}
	},
}

def print_debug(message):
	if debug:
		print("DEBUG: %s" % message)

filename = sys.argv[1]

try:
	target = sys.argv[2]
except IndexError:
	print("Target is not set")
	exit(2)

if not os.path.isfile(filename):
	print("Filename is not a regular file")
	exit(3)

for (project_name, project) in projects.items():
	try:
		(destination, count) = re.subn(project['source'], project['destination'][target]['directory'], filename, flags=re.IGNORECASE)
		destination = os.path.dirname(destination) + '/'
	except KeyError:
		print("Project %s doesn't have target %s" % (project_name, target))
		continue

	if count > 0:
		config = project['destination'][target]
		command = list(scp_command)
		command.append("-v")
		command.append("-rclD")
		command.append("-zO")
		command.append("--chmod=D775,F664")

		command.append(filename.replace('C:/', '/cygdrive/c/'))

		for host in config['hosts']:
			command.append("{}:{}".format(host, destination))

			print_debug(command)
			try:
				subprocess.check_output(command, stdin=subprocess.PIPE, stderr=subprocess.STDOUT)
				print('Upload of {} to {} successful'.format(filename, host))
			except subprocess.CalledProcessError as err:
				print("SCP command failed\nCommand was: {0}\n".format(" ".join(['"%s"' % item for item in command])))
				print(str(err.output))
				exit(4)

			command.pop()

		exit(0)
	else:
		print_debug("Filename %s doesn't match project %s" % (filename, project_name))

print("No project was matched for filename %s" % (filename))
exit(5)

