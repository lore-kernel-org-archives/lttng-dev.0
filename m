From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: lttng, lttng-sessiond and the tracing group
Date: Wed, 6 Feb 2013 15:48:52 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD013EB1__25858.7570897818$1360165820$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1U37FX-0005ee-Cb
	for lttng-dev@lists.lttng.org; Wed, 06 Feb 2013 10:49:27 -0500
Content-Language: fr-FR
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

   The lttng man pages are a little vague as to the relationship between lt=
tng, the lttng-sessiond, and the tracing group.  My experiments have shown =
that a user belonging to the tracing group should more or less be able to i=
ssue lttng commands as if they were prefixed with sudo, but that's not quit=
e right, as we'll see.  Is there a document outlining the operational conce=
pt?

   First observation

   A user in the tracing group who issues an lttng command will launch a us=
er lttng-sessiond only if the root lttng-sessiond isn't already running.  T=
hat user can easily set up both lttng-sessiond daemons by first stopping th=
e root lttng-sessiond, and then issuing a couple of 'lttng list' commands, =
the first at user level, the second at root level (using sudo).  If he then=
 creates a user-level trace, it'll be listed by both 'lttng trace' and 'sud=
o lttng trace'.  A subsequent root-level trace ('sudo lttng create ...') wi=
ll be listed only by the root daemon.  A problem that arises at this point =
is that both daemons use the same ~/.lttngrc file to track the current sess=
ion, so since in this scenario the root trace was created last any defaulti=
ng at the user level will be erroneous.  Specifically:

(user belongs to tracing and sudo groups)
(~/.lttngrc does not exist)

$ sudo stop lttng-sessiond
lttng-sessiond stop/waiting
$ lttng -vvv list
Spawning a session daemon                                                  =
                                <-- user-level lttng-sessiond
DEBUG1: SIGUSR1 caught [in sighandler() at lttng.c:198]
DEBUG2: Session name: (null) [in cmd_list() at commands/list.c:720]
DEBUG1: LSM cmd type : 13 [in send_session_msg() at lttng-ctl.c:261]
DEBUG1: Session count 0 [in list_sessions() at commands/list.c:588]
Currently no available tracing session
$ sudo lttng -vvv list
Spawning a session daemon                                                  =
                                <-- root-level lttng-sessiond
DEBUG1: SIGUSR1 caught [in sighandler() at lttng.c:198]
DEBUG2: Session name: (null) [in cmd_list() at commands/list.c:720]
DEBUG1: LSM cmd type : 13 [in send_session_msg() at lttng-ctl.c:261]
DEBUG1: Session count 0 [in list_sessions() at commands/list.c:588]
Currently no available tracing session
$ lttng -vvv create userlevel
DEBUG3: URI string: file:///home/daniel/lttng-traces/userlevel-20130206-091=
913 [in uri_parse() at uri.c:253]
DEBUG3: URI file destination: /home/daniel/lttng-traces/userlevel-20130206-=
091913 [in uri_parse() at uri.c:290]
DEBUG3: URI dtype: 3, proto: 0, host: , subdir: , ctrl: 0, data: 0 [in uri_=
parse() at uri.c:467]
DEBUG1: LSM cmd type : 8 [in send_session_msg() at lttng-ctl.c:261]
Session userlevel created.
Traces will be written in /home/daniel/lttng-traces/userlevel-20130206-0919=
13
DEBUG1: Init config session in /home/daniel [in config_init() at conf.c:294]
$ sudo lttng -vvv list
DEBUG2: Session name: (null) [in cmd_list() at commands/list.c:720]
DEBUG1: LSM cmd type : 13 [in send_session_msg() at lttng-ctl.c:261]
DEBUG1: Session count 1 [in list_sessions() at commands/list.c:588]
Available tracing sessions:
  1) userlevel (/home/daniel/lttng-traces/userlevel-20130206-091913) [inact=
ive]

Use lttng list <session_name> for more details
$ lttng -vvv list
DEBUG2: Session name: (null) [in cmd_list() at commands/list.c:720]
DEBUG1: LSM cmd type : 13 [in send_session_msg() at lttng-ctl.c:261]
DEBUG1: Session count 1 [in list_sessions() at commands/list.c:588]
Available tracing sessions:
  1) userlevel (/home/daniel/lttng-traces/userlevel-20130206-091913) [inact=
ive]

Use lttng list <session_name> for more details
$ sudo lttng -vvv create rootlevel
DEBUG3: URI string: file:///home/daniel/lttng-traces/rootlevel-20130206-091=
954 [in uri_parse() at uri.c:253]
DEBUG3: URI file destination: /home/daniel/lttng-traces/rootlevel-20130206-=
091954 [in uri_parse() at uri.c:290]
DEBUG3: URI dtype: 3, proto: 0, host: , subdir: , ctrl: 0, data: 0 [in uri_=
parse() at uri.c:467]
DEBUG1: LSM cmd type : 8 [in send_session_msg() at lttng-ctl.c:261]
Session rootlevel created.
Traces will be written in /home/daniel/lttng-traces/rootlevel-20130206-0919=
54
DEBUG1: Init config session in /home/daniel [in config_init() at conf.c:294]
$ sudo lttng -vvv list                                                     =
                                                         <-- at this point =
.lttngrc contains 'session=3Drootlevel'
DEBUG2: Session name: (null) [in cmd_list() at commands/list.c:720]
DEBUG1: LSM cmd type : 13 [in send_session_msg() at lttng-ctl.c:261]
DEBUG1: Session count 2 [in list_sessions() at commands/list.c:588]
Available tracing sessions:
  1) rootlevel (/home/daniel/lttng-traces/rootlevel-20130206-091954) [inact=
ive]
  2) userlevel (/home/daniel/lttng-traces/userlevel-20130206-091913) [inact=
ive]

Use lttng list <session_name> for more details
$ lttng -vvv list
DEBUG2: Session name: (null) [in cmd_list() at commands/list.c:720]
DEBUG1: LSM cmd type : 13 [in send_session_msg() at lttng-ctl.c:261]
DEBUG1: Session count 1 [in list_sessions() at commands/list.c:588]
Available tracing sessions:
  1) userlevel (/home/daniel/lttng-traces/userlevel-20130206-091913) [inact=
ive]

Use lttng list <session_name> for more details
$ lttng -vvv list userlevel
DEBUG2: Session name: userlevel [in cmd_list() at commands/list.c:720]
DEBUG1: LSM cmd type : 13 [in send_session_msg() at lttng-ctl.c:261]
DEBUG1: Session count 1 [in list_sessions() at commands/list.c:588]
Tracing session userlevel: [inactive]
    Trace path: /home/daniel/lttng-traces/userlevel-20130206-091913

DEBUG1: LSM cmd type : 11 [in send_session_msg() at lttng-ctl.c:261]
$ lttng -vvv list rootlevel
DEBUG2: Session name: rootlevel [in cmd_list() at commands/list.c:720]
DEBUG1: LSM cmd type : 13 [in send_session_msg() at lttng-ctl.c:261]
DEBUG1: Session count 1 [in list_sessions() at commands/list.c:588]
Error: Session 'rootlevel' not found
Error: Command error
DEBUG1: Clean exit [in clean_exit() at lttng.c:169]
$ lttng -vvv start                                                         =
                                                        <-- you'd expect th=
is to start the userlevel trace
DEBUG2: Config file path found: /home/daniel [in get_session_name() at util=
s.c:50]
DEBUG1: Session name found: rootlevel [in get_session_name() at utils.c:51]
DEBUG1: Starting tracing for session rootlevel [in start_tracing() at comma=
nds/start.c:81]
DEBUG1: LSM cmd type : 16 [in send_session_msg() at lttng-ctl.c:261]
Error: Permission denied
DEBUG1: Clean exit [in clean_exit() at lttng.c:169]

   At this point the user cannot use 'service lttng-sessiond stop' or 'stop=
 lttng-sessiond' to stop the user-level daemon: his only recourse is the ki=
ll command.  This is normal, since service and start/stop both deal with Sy=
stem V init and/or Upstart.

   Of course the above is a little contrived because it's all from a single=
 console, but you could easily have another user running the root-level ltt=
ng commands in parallel to an unknowing user.

   Second observation

   Contention for ~/.lttngrc can lead to odd behaviour.  This can only occu=
r with users in the tracing group, I think (the root lttng-sessiond has no =
business writing to a non-tracing user's home directory).  Witness this:

(user belongs to tracing and sudo groups)
(~/.lttngrc does not exist)

$ sudo lttng -vvv create rootlevel
DEBUG3: URI string: file:///home/daniel/lttng-traces/rootlevel-20130205-162=
212 [in uri_parse() at uri.c:253]
DEBUG3: URI file destination: /home/daniel/lttng-traces/rootlevel-20130205-=
162212 [in uri_parse() at uri.c:290]
DEBUG3: URI dtype: 3, proto: 0, host: , subdir: , ctrl: 0, data: 0 [in uri_=
parse() at uri.c:467]
DEBUG1: LSM cmd type : 8 [in send_session_msg() at lttng-ctl.c:261]
Session rootlevel created.
Traces will be written in /home/daniel/lttng-traces/rootlevel-20130205-1644=
35
DEBUG1: Init config session in /home/daniel [in config_init() at conf.c:294]
$ sudo lttng -vvv list                                                     =
                                                         <-- At this point =
~./.lttngrc is root-owned, contents 'session=3Drootlevel'
DEBUG2: Session name: (null) [in cmd_list() at commands/list.c:720]
DEBUG1: LSM cmd type : 13 [in send_session_msg() at lttng-ctl.c:261]
DEBUG1: Session count 1 [in list_sessions() at commands/list.c:588]
Available tracing sessions:
  1) rootlevel (/home/daniel/lttng-traces/rootlevel-20130205-164435) [inact=
ive]

Use lttng list <session_name> for more details
$ lttng -vvv list
DEBUG2: Session name: (null) [in cmd_list() at commands/list.c:720]
DEBUG1: LSM cmd type : 13 [in send_session_msg() at lttng-ctl.c:261]
DEBUG1: Session count 0 [in list_sessions() at commands/list.c:588]
Currently no available tracing session
$ lttng -vvv create rootlevel
DEBUG3: URI string: file:///home/daniel/lttng-traces/rootlevel-20130205-164=
617 [in uri_parse() at uri.c:253]
DEBUG3: URI file destination: /home/daniel/lttng-traces/rootlevel-20130205-=
164617 [in uri_parse() at uri.c:290]
DEBUG3: URI dtype: 3, proto: 0, host: , subdir: , ctrl: 0, data: 0 [in uri_=
parse() at uri.c:467]
DEBUG1: LSM cmd type : 8 [in send_session_msg() at lttng-ctl.c:261]
Warning: Session rootlevel already exists
Error: Session name already exist
DEBUG1: Clean exit [in clean_exit() at lttng.c:169]                        =
                            <-- user will be puzzled that a session name ca=
n already exist if the list of sessions is empty
$ sudo lttng -vvv list
DEBUG2: Session name: (null) [in cmd_list() at commands/list.c:720]
DEBUG1: LSM cmd type : 13 [in send_session_msg() at lttng-ctl.c:261]
DEBUG1: Session count 1 [in list_sessions() at commands/list.c:588]
Available tracing sessions:
  1) rootlevel (/home/daniel/lttng-traces/rootlevel-20130205-164435) [inact=
ive]

Use lttng list <session_name> for more details
$ lttng -vvv list
DEBUG2: Session name: (null) [in cmd_list() at commands/list.c:720]
DEBUG1: LSM cmd type : 13 [in send_session_msg() at lttng-ctl.c:261]
DEBUG1: Session count 0 [in list_sessions() at commands/list.c:588]
Currently no available tracing session
$ lttng -vvv create userlevel
DEBUG3: URI string: file:///home/daniel/lttng-traces/userlevel-20130205-164=
835 [in uri_parse() at uri.c:253]
DEBUG3: URI file destination: /home/daniel/lttng-traces/userlevel-20130205-=
164835 [in uri_parse() at uri.c:290]
DEBUG3: URI dtype: 3, proto: 0, host: , subdir: , ctrl: 0, data: 0 [in uri_=
parse() at uri.c:467]
DEBUG1: LSM cmd type : 8 [in send_session_msg() at lttng-ctl.c:261]
Session userlevel created.
Traces will be written in /home/daniel/lttng-traces/userlevel-20130205-1648=
35
Error: Unable to create config file                                        =
                                                       <-- user can't acces=
s a root-owned .lttngrc
Error: Command error
DEBUG1: Clean exit [in clean_exit() at lttng.c:169]
$ sudo lttng -vvv list
DEBUG2: Session name: (null) [in cmd_list() at commands/list.c:720]
DEBUG1: LSM cmd type : 13 [in send_session_msg() at lttng-ctl.c:261]
DEBUG1: Session count 2 [in list_sessions() at commands/list.c:588]
Available tracing sessions:
  1) userlevel (/home/daniel/lttng-traces/userlevel-20130205-164835) [inact=
ive]    <-- despite the error, the userlevel session is created
  2) rootlevel (/home/daniel/lttng-traces/rootlevel-20130205-164435) [inact=
ive]

Use lttng list <session_name> for more details
$ lttng -vvv list
DEBUG2: Session name: (null) [in cmd_list() at commands/list.c:720]
DEBUG1: LSM cmd type : 13 [in send_session_msg() at lttng-ctl.c:261]
DEBUG1: Session count 1 [in list_sessions() at commands/list.c:588]
Available tracing sessions:
  1) userlevel (/home/daniel/lttng-traces/userlevel-20130205-164835) [inact=
ive]

Use lttng list <session_name> for more details                             =
                                           <-- .lttngrc is still root-owned=
, still contains 'session=3Drootlevel'
$ lttng -vvv destroy                                                       =
                                                                        <--=
 user expects to destroy the session he just created
DEBUG2: Config file path found: /home/daniel [in get_session_name() at util=
s.c:50]
DEBUG1: Session name found: rootlevel [in get_session_name() at utils.c:51]
DEBUG1: LSM cmd type : 9 [in send_session_msg() at lttng-ctl.c:261]
DEBUG1: Clean exit [in clean_exit() at lttng.c:169]                        =
                                          <-- note the lack of feedback, ev=
en though the destroy failed completely
$ sudo lttng -vvv list
DEBUG2: Session name: (null) [in cmd_list() at commands/list.c:720]
DEBUG1: LSM cmd type : 13 [in send_session_msg() at lttng-ctl.c:261]
DEBUG1: Session count 2 [in list_sessions() at commands/list.c:588]
Available tracing sessions:
  1) userlevel (/home/daniel/lttng-traces/userlevel-20130205-164835) [inact=
ive]
  2) rootlevel (/home/daniel/lttng-traces/rootlevel-20130205-164435) [inact=
ive]

Use lttng list <session_name> for more details
$ lttng -vvv list
DEBUG2: Session name: (null) [in cmd_list() at commands/list.c:720]
DEBUG1: LSM cmd type : 13 [in send_session_msg() at lttng-ctl.c:261]
DEBUG1: Session count 1 [in list_sessions() at commands/list.c:588]
Available tracing sessions:
  1) userlevel (/home/daniel/lttng-traces/userlevel-20130205-164835) [inact=
ive]

Use lttng list <session_name> for more details
$ lttng -vvv destroy userlevel
DEBUG1: LSM cmd type : 9 [in send_session_msg() at lttng-ctl.c:261]
Session userlevel destroyed
DEBUG1: Removing /home/daniel/.lttngrc                                     =
                                          <-- note how user destroyed a roo=
t-owned ~./.lttngrc
 [in config_destroy() at conf.c:151]
$ sudo lttng -vvv list
DEBUG2: Session name: (null) [in cmd_list() at commands/list.c:720]
DEBUG1: LSM cmd type : 13 [in send_session_msg() at lttng-ctl.c:261]
DEBUG1: Session count 1 [in list_sessions() at commands/list.c:588]
Available tracing sessions:
  1) rootlevel (/home/daniel/lttng-traces/rootlevel-20130205-164435) [inact=
ive]

Use lttng list <session_name> for more details
$ lttng -vvv list
DEBUG2: Session name: (null) [in cmd_list() at commands/list.c:720]
DEBUG1: LSM cmd type : 13 [in send_session_msg() at lttng-ctl.c:261]
DEBUG1: Session count 0 [in list_sessions() at commands/list.c:588]
Currently no available tracing session
$ lttng -vvv destroy -a
DEBUG1: LSM cmd type : 13 [in send_session_msg() at lttng-ctl.c:261]
No session found, nothing to do.
$ sudo lttng -vvv destroy -a
DEBUG1: LSM cmd type : 13 [in send_session_msg() at lttng-ctl.c:261]
DEBUG1: LSM cmd type : 9 [in send_session_msg() at lttng-ctl.c:261]
Session rootlevel destroyed

   Third observation

   'lttng set-session' issues an error only if there is no name specified o=
r if the name is too long (or if .lttngrc is root-owned, of course): it'll =
happily change the contents to whatever the argument is, including non-exis=
tent sessions or even illegal session names (containing embedded '/', for e=
xample).  A too-long session name (246 characters or more) also has the unf=
ortunate side effect of wiping the contents of .lttngrc.  You can also end =
up with sessions which are "sort of created":

$ lttng -vvv create 1234567810123456782012345678301234567840123456785012345=
678601234567870123456788012345678901234567100123456711012345671201234567130=
123456714012345671501234567160123456717012345671801234567190123456720012345=
67210123456722012345672301234567240123456
DEBUG3: URI string: file:///home/daniel/lttng-traces/1234567810123456782012=
345678301234567840123456785012345678601234567870123456788012345678901234567=
100123456711012345671201234567130123456714012345671501234567160123456717012=
34567180123456719012345672001234567210123456722012345672301234567240123456-=
2013020 [in uri_parse() at uri.c:253]
DEBUG3: URI file destination: /home/daniel/lttng-traces/1234567810123456782=
012345678301234567840123456785012345678601234567870123456788012345678901234=
567100123456711012345671201234567130123456714012345671501234567160123456717=
012345671801234567190123456720012345672101234567220123456723012345672401234=
56-2013020 [in uri_parse() at uri.c:290]
DEBUG3: URI dtype: 3, proto: 0, host: , subdir: , ctrl: 0, data: 0 [in uri_=
parse() at uri.c:467]
DEBUG1: LSM cmd type : 8 [in send_session_msg() at lttng-ctl.c:261]
Session 1234567810123456782012345678301234567840123456785012345678601234567=
870123456788012345678901234567100123456711012345671201234567130123456714012=
345671501234567160123456717012345671801234567190123456720012345672101234567=
22012345672301234567240123456 created.
Traces will be written in /home/daniel/lttng-traces/12345678101234567820123=
456783012345678401234567850123456786012345678701234567880123456789012345671=
001234567110123456712012345671301234567140123456715012345671601234567170123=
4567180123456719012345672001234567210123456722012345672301234567240123456-2=
013020
Error: Command error
DEBUG1: Clean exit [in clean_exit() at lttng.c:169]

   In this case I created a session with a 246-character name but got an er=
ror, and the output directory has an unexpectedly truncated name.  A sessio=
n with a 245-character name will be created without an error but will still=
 have an unexpectedly truncated output path.  Odds are this will cause trou=
ble further down the line.  NAME_MAX is 255 on my system.

Daniel U. Thibault
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critical =
Cyber Security (MCCS)
Protection des syst=E8mes et contremesures (PSC) / Systems Protection & Cou=
ntermeasures (SPC)
2459 route de la Bravoure
Qu=E9bec, QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada / Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
