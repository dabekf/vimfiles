# -*- coding: UTF-8 -*-
import vim
import re
import os
import posixpath
import sys
import traceback
from pprint import pprint
assert pprint

import subprocess
try:
	import paramiko
except ImportError:
	pass

if 'paramiko' in sys.modules:
	try:
		_host_keys = paramiko.util.load_host_keys(os.path.expandvars("C:/Cygwin64/home/$USERNAME/.ssh/known_hosts"))
	except FileNotFoundError:
		_host_keys = {}

	try:
		_pkey = paramiko.RSAKey.from_private_key_file(os.path.expandvars('C:/Cygwin64/home/$USERNAME/.ssh/id_rsa'))
	except FileNotFoundError:
		_pkey = None

_projects = {
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
				'directory': r'/home/www/\2.polskikoszyk.pl', # regular replacement
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

def MyconfRsyncUpload():
	_debug = False
	_quickfix_ready = False

	filename = vim.eval('b:myconf_rsync_filename')
	target = vim.eval('b:myconf_rsync_target')

	scp_command = ("rsync",)


	def print_debug(message):
		if _debug:
			print("DEBUG: %s" % message)


	def add_error(message):
		nonlocal _quickfix_ready
		if not _quickfix_ready:
			vim.command("cex ''")
			_quickfix_ready = True
			add_error("MyconfRsyncUpload() failed for {}".format(filename))

		if type(message) == list:
			for line in message:
				add_message(line)
		else:
			add_message(message)


	def add_message(message):
		vim.command("cadde '{}'".format(str(message).replace("'", '"')))


	def set_status(status):
		vim.command("let b:myconf_rsync_status = '{}'".format(status))


	if not os.path.isfile(filename):
		add_error("filename is not a regular file")
		set_status("error")
		return False

	for (project_name, project) in _projects.items():
		try:
			(destination, count) = re.subn(project['source'], project['destination'][target]['directory'], filename, flags=re.IGNORECASE)
			destination_dir = os.path.dirname(destination) + '/'
		except KeyError:
			add_error("project %s doesn't have target %s" % (project_name, target))
			set_status("error")
			return False

		if count > 0:
			config = project['destination'][target]

			if 'paramiko' in sys.modules:
				# use paramiko
				for host in config['hosts']:
					password = None # always use publickey
					(username, hostname) = host.split('@')
					try:
						(hostname, port) = hostname.split(':')
					except ValueError:
						port = 22

					try:
						hostkeytype = None
						hostkey = None
						if hostname in _host_keys:
							hostkeytype = _host_keys[hostname].keys()[0]
							hostkey = _host_keys[hostname][hostkeytype]

						if not _pkey:
							raise FileNotFoundError('Private key file is missing')

						t = paramiko.Transport((hostname, port))
						t.connect(
							hostkey,
							username,
							password,
							pkey=_pkey,
						)
						sftp = paramiko.SFTPClient.from_transport(t)

						try:
							sftp.put(filename, destination)
						except FileNotFoundError:
							# make all missing directiories
							path = "/".join(destination_dir.split('/')[0:len(project['destination'][target]['directory'].split('/'))])
							subdirs = destination_dir.split('/')[len(project['destination'][target]['directory'].split('/')):-1]

							for subdir in subdirs:
								path = posixpath.join(path, subdir)

								try:
									sftp.listdir(path)
								except FileNotFoundError:
									sftp.mkdir(path)

							sftp.put(filename, destination)

						set_status("done")
						return True
					except Exception as ex:
						add_error(traceback.format_exc().split('\n'))
						set_status("error")
						return False
			else:
				# use subprocess
				command = list(scp_command)
				command.append("-v")
				command.append("-rclD")
				command.append("-zO")
				command.append("--chmod=D775,F664")

				command.append(re.sub('^([A-Z]):/', '/cygdrive/\\1/'.lower(), filename))

				for host in config['hosts']:
					command.append("{}:{}".format(host, destination_dir))

					print_debug(command)
					try:
						subprocess.run(command, capture_output=True, creationflags=subprocess.DETACHED_PROCESS, timeout=10, check=True)
						# print('Upload of {} to {} successful'.format(filename, host))
						set_status("done")
						return True
					except subprocess.CalledProcessError as ex:
						add_error("command was: {}".format(" ".join(['"%s"' % item for item in command])))
						add_error(ex.stderr.decode().split('\n'))
						set_status("error")
						return False
					except Exception as ex:
						add_error(traceback.format_exc().split('\n'))
						set_status("error")
						return False

					command.pop()

		else:
			print_debug("filename %s doesn't match project %s" % (filename, project_name))

	add_error("no project was matched for filename %s" % (filename))
	set_status("error")
	return False

