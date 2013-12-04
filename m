From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: RFC LTTng session and daemon configuration save and
	restore
Date: Wed, 4 Dec 2013 16:33:09 -0500
Message-ID: <CA+jJMxv-mg_Lx1DdZHq7LyETNmULZ=MMKUoHqMhc5t3o9BJRkg__48621.1882242516$1386192849$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1VoK4J-0007w6-Fl
	for lttng-dev@lists.lttng.org; Wed, 04 Dec 2013 16:33:17 -0500
Received: by mail-qa0-f43.google.com with SMTP id ii20so7034458qab.16
	for <lttng-dev@lists.lttng.org>; Wed, 04 Dec 2013 13:33:10 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

RFC - LTTng session and daemon configuration save and restore

Author: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>

Version:
- v0.2: 04/12/2013
* Reorganized the text following David Goulet's recommendations
- v0.1: 03/12/2013
* Initial proposal

Introduction
-------------

This proposal details the file formats, LTTng APIs and command line interfa=
ces
used to save and restore session and daemon configurations.


Daemon Configuration File Format
--------------------------------

The LTTng session and relay daemons shall be configurable using INI
configuration files. The set of configuration options accepted by LTTng dae=
mons
corresponds to the command line options available for each daemon.

The sections in the files must match the daemons' names: [sessiond] and
[relayd]. The entries under each section must match the long option names
supported by the daemons. Options specified on the command line shall always
have precedence over options set by the configuration files.

An example demonstrating the use of such configuration
options follows.

[sessiond]
consumerd32-path=3D/lib/lttng/libexec/lttng-consumerd
consumerd64-path=3D/lib64/lttng/libexec/lttng-consumerd
no-kernel=3D1

[relayd]
data-port=3Dtcp://0.0.0.0:5343
output=3D/tmp/MyTraces

Daemon configuration files are, by default, either stored system-wide under
/etc/lttng/*.conf or in the user's home directory under $HOME/.lttng/*.conf.

New options may be added to the daemon configuration file as features are
added to the relay and session daemons. The daemons shall ignore unrecogniz=
ed
options to ensure forward compatibility.


LTTng Command Line - Daemon Configuration
-----------------------------------------

On launch, the session, relay and consumer daemons will search for files wi=
th
the .conf extension in the following folders, in order of precedence:
1) Any path specified using a new --load-config option
2) $HOME/.lttng/*.conf
3) /etc/lttng/*.conf


Session Configuration File Format
---------------------------------

The LTTng session configuration file format must enable the serialization o=
f the
session, channel and event structures of the LTTng API. Since these concepts
are eminently hierarchical, it only makes sense to use a file format that c=
an
express such relationships.

While an INI based file format was the first considered, for its ease of use
and human readability, it appears that INI provides no standard way of
expressing hierarchies. It is, of course, possible to flatten session/chann=
el
hierarchies using prefixed section names, but this is both error prone and
unsupported by most INI file reading libraries. This means that we would ha=
ve
to code our own INI handling code and produce a specification to document o=
ur
additions to the INI format. INI also provides no standard versioning mecha=
nism.

In keeping with the desire to use a human-readable format, we have consider=
ed
rolling our own format. This format could express hierarchy using tabulatio=
ns
to delimit scopes, not unlike the Python language. Such a format would be b=
oth
relatively easy to parse, but also readable. However, this both requires
documenting the format in a specification, rolling our own parsing and
validation code, thus losing the benefit of reusing external libraries. This
option has the highest maintenance cost considering the amount of code and
documentation to be produced while presenting marginal benefits over the INI
approach.

Finally, it seems that using a standard hierarchical format such as JSON or
XML would be the most appropriate choice. Both of these formats have intrin=
sic
support for representation of hierarchical relationships. They also benefit=
 from
having a lot of hardened external libraries that will provide parsing,
validation and write support. This is a huge advantage from both
maintainability and interoperability standpoints. However, both formats
present the disadvantage of being harder, although minimally, to edit manua=
lly.
It remains to be seen if manual editing of session configurations really is=
 an
important use-case. Using lttng's save feature would probably prove more
convenient than editing the files manually. Furthermore, the addition of a
"dry-run" option to the lttng client would significantly alleviate this pain
point.

XML seems like a better option than JSON since it makes it possible to have
robust file validation using a pre-defined schema. The use of version-speci=
fic
schemas could also be beneficial for backward compatibility as the format
moves forward. Finally, character encoding handling is already a solved
problem for most XML libraries.


LTTng ABI/API
-------------

Two new functions are added to the lttng.h API.

int lttng_load_sessions(const char *url, const char *session_name,
int flags/struct lttng_session_load_attr *attr);

Load sessions. If url the is a directory, all .lttng files it contains will=
 be
loaded. If session_name is NULL, all sessions found in url are restored.
If a session_name is provided, only this session will be restored.

A supplementary argument, either a "flags" argument or an attribute structu=
re,
is used to indicate whether or not the sessions currently known to the
session daemon should be replaced by the ones found in the configuration
file(s), provided that their names are the same.
Even though this is the only current use-case for this argument, a structure
with a reasonable amount of padding may be more suitable than a primary
type to accommodate new features. Thoughts?


int lttng_save_sessions(const char *url, const char *session_name
int flags/struct lttng_session_save_attr *attr);

Save sessions. If url is a directory, the session configuration will be sav=
ed
as session_name.lttng. If a complete file name is provided, the session(s) =
to be
saved will be written to this file. If session_name is NULL, all sessions
currently known to the session daemon will be saved. If a name is provided,=
 only
that session will be saved.

The reasoning for the flags/attr argument is the same as for the
lttng_load_sessions() function, but for a configuration file overwrite
option.


LTTng Command Line - Session Configuration
------------------------------------------

Tracing session configurations can be saved and restored using the lttng co=
mmand
line client. This capability introduces two new command line options.


-- Load session configurations --

$ lttng load -s SESSION_NAME [OPTIONS]

Loads tracing session configurations.

.lttng files will be searched in the following default paths, in order of
precedence:
1) $(HOME)/.lttng/sessions
2) /etc/lttng/sessions

A session name or the -a option must be passed as the SESSION_NAME argument.
Like some other lttng commands, such as enable-event, the -a option stands =
for
"all". If this option is used, every session found in the paths will be loa=
ded.

If a session was saved as active, the tracing for that session will be acti=
vated
automatically on load. The current session configuration of the session dae=
mon
is also preserved when a configuration is loaded. The new session configura=
tions
are added to the current session set.

Tracing sessions saved in an active state will be resumed on load.

--input-path, -i
Path in which to search for SESSION_NAME's description. If the path is a
directory, all .lttng files it contains will be opened and searched for
SESSION_NAME. If an input path is provided, the -a option will load all
session configurations found in this path. The default paths are ignored wh=
en
this option is used.

--force, -f
If a restored session's name conflicts with a currently existing session, t=
he
original session configuration is preserved. However, if the --force option=
 is
used, the restored session takes precedence. The original session will be
destroyed.


-- Save session configurations --

$ lttng save -s SESSION_NAME [OPTIONS]

Saves tracing configurations.

The selected tracing session's configuration will be saved in the
$HOME/.lttng/sessions folder. If the -a option is used, every session known
to the session daemon will be saved.

--output-path, -o
If the provided output path is a directory, the session will be saved in a
file named "SESSION_NAME.lttng". However, if the path is a file, the sessio=
n(s)
will all be saved in the same file.


-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
