From: David Goulet <dgoulet@efficios.com>
Subject: Re: lttng command line user-friendliness
Date: Mon, 10 Sep 2012 11:00:18 -0400
Message-ID: <504E0082.9040502__38495.0939369903$1347289260$gmane$org@efficios.com>
References: <504DCE2E.7020000@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TB5TM-0006ao-5o
	for lttng-dev@lists.lttng.org; Mon, 10 Sep 2012 11:00:24 -0400
In-Reply-To: <504DCE2E.7020000@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi Paul,

Woegerer, Paul:
> As much as I like the lttng command line tool (that we have since 
> LTTng2) I still see people (who are not yet familiar with lttng) 
> struggle with the simple fact that it takes more than one command
> to actually get something traced.
> 
> Issuing a sequence of commands like:
> 
> lttng create lttng enable-event -u -a lttng start 
> my_foobar_traced_application 1 2 3 lttng stop lttng destroy
> 

Small note here that the "destroy" is not needed. The stop forces a
subbuffer switch meaning that the current data collected is written to
the trace files.

> seems to be perceived as complicated compared to:
> 
> perf record -- my_foobar_traced_application 1 2 3
> 
> My argument usually is that providing detailed settings as options
> (like perf) does not scale as well as the lttng approach (if you
> have more things to configure). On the other hand most users just
> want something like the above. Also arguing that they should write
> a shell-script that encodes their use case generally causes
> irritation ("... please understand, I do not want to write a
> shell-script I just want to do simple tracing of my executable
> ...").
> 
> What about adding something similar to "perf record" to lower the 
> barrier for such users. For example:
> 
> lttng record [--session-name <name>] [--session-template 
> <session_template_file>]  -- <command> [<options>]
> 
> Where the optional session_template_file may only contain 
> "enable-channel, enable-event and add-context" commands. If omitted
> the following could be the (trivial) default session template:
> 
> enable-event -u -a
> 
> 
> Would this make sense for others as well ? Any alternative
> suggestions ?

This totally makes sense and is also something we are looking to do
for a long time.

We were thinking of a "lttng trace [...]" command that would wrap the
session creation, enabling all events for a domain (kernel or/and user
space) and start the trace by outputting either the trace live like
strace or at an output destination. For the live tracing, it's our
next step right NOW so the next 2.2 version *should* have this and
would make total sense also to have this command!

To be honest, we have almost everything (on the technical side) to
create this command (except the live tracing), we just don't have it
now because of a priority/time issue :).

I would however encourage everyone on this list who is willing to
continue this thread in order to come up with a small RFC for the command.

RFC/Discussion:

lttng record [--session-name <name>] [--session-template
<session_template_file>]  -- <command> [<options>]

Either "trace" or "record", I guess it's a simple aesthetic choice
here :).

With more options here to set either a custom destination or live
trace. What's the default? (no opts given). I would personally go for
a default one being to record in the session default trace files and
add a "-l" for the live.

	-o, --output=DST
	-l, --live

Add a domain option where nothing enables kernel AND ust or else the
command can take either -u or -k.

Please, contribute to this, no bad ideas, only bad answers! :)

Cheers and thanks Paul for comment!
David

> 
> Thanks, Paul
> 
-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJQTgB+AAoJEELoaioR9I02zzoIAMd+nG8KLZnmHiFQU9Tcqq9Q
N+jLVU/JjMuzjpQluD+1Xe3O9yLDu/mEqGAddYBQ5RnkHS7DveFwfY697nESqJPR
qV0Y3ajbIC30WMrnweZSypsj9xAv33ZzFn4C/DuYIylicqpcX8mxcMgLzI9duoRQ
/kxOqIeBLvl5C/pFSR55vki3fxhHPg67f2S9TgFDiBEPmaL0UkxpfOaB3G86Bj8z
Kp7oKCCbQzv0R3J4BlcNRNUXKTClo3Qjb/ZyWGgFwwErZJoADcd+osvIU9raA7MY
yEEExx5t4OMjEyrb3eqJgihH+xMx6eW1275vz2TV4ayBIg1YuJrIzUY/zgVkYn0=
=f6QB
-----END PGP SIGNATURE-----
