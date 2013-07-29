From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: [RFC] Dynamic instrumentation support in UST
Date: Mon, 29 Jul 2013 13:49:12 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD1BE24A83__2548.69616260311$1375105817$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1V3npN-00065p-GL
	for lttng-dev@lists.lttng.org; Mon, 29 Jul 2013 09:49:34 -0400
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

----------------------------------------------------------------------
> Date: Fri, 26 Jul 2013 23:40:33 +0800
> From: Zifei Tong <soariez@gmail.com>
>
> Command Line Interface
> ----------------------
>
> To enable a dynamic probe in a running process at given address, you can =
use:
>     lttng enable-event NAME -u --pid PID
>         --probe (addr | symbol | symbol+offset)
>                                Dynamic UST probe.
>                                Addr and offset can be octal (0NNN...),
>                                decimal (NNN...) or hexadecimal (0xNNN...)
>
> This will place a bare probe at certain address.

   Unless I'm mistaken, currently lttng's 'enable-event -u ...' works only =
on already-running user-space processes.  It should be fairly easy to chang=
e this so the event gets enabled for any new user-space process that regist=
ers itself with the session daemon while the session is in existence.  This=
 would be possible only for instrumented applications, of course.  It shoul=
d also be possible to extend this to uninstrumented applications, as long a=
s the session daemon watches for new processes being launched.

   I would allow the above command line to specify a process name instead o=
f a process ID, in order to capture multi-threaded and multi-instance proce=
sses.  When using process IDs, one also has to be careful of PID namespaces=
: for a member of the 'tracing' group, a PID issued from a local lttng comm=
and (e.g. '$ lttng enable-event --pid ...') may need to be translated by th=
e time it reaches the root lttng-sessiond.  Similar concerns exist with use=
r namespaces.  The implications of namespaces are not peculiar to this exte=
nsion of lttng, however: I would expect lttng to provide namespace-handling=
 utility functions or to otherwise handle namespaces consistently throughou=
t its services.

> Being only able to attach and instrument existing processes is sometimes =
restricted. If we can have #15 [2] implemented, then we can extend the comm=
and to support dynamic instrumentation.
>
>    lttng trace -c COMMAND
>        --probe (addr | symbol | symbol+offset)
>        --function (addr | symbol | symbol+offset)
>
> This will execute given program and place probes at certain places.

   The -c command option by itself may be insufficient in some cases.  For =
instance, if the lttng command is issued from an su shell (e.g. '# lttng tr=
ace -c ...'), from a 'tracing' group member (e.g. '$ lttng trace -c ...'), =
or from some ordinary account (e.g. '$ sudo -H lttng trace -c ...'), the in=
tent may be to specify which user account to run the COMMAND as.  An 'lttng=
 trace' command would be problematic anyway since it may need to specify se=
veral events to enable, each assigned to a different channel and possibly w=
ith a filter as well.  The overall command line could become very unwieldy.=
  If enable-event is able to set up latent events (as described in my previ=
ous comment block), then 'lttng trace' is unnecessary: the user need only s=
et up his events, channels, etc., using --processname and then issue a prop=
er 'sudo' command to launch the process (sudo has all the requisite options=
 to assign the process to the proper user account with the proper environme=
nt settings, etc.).
------------------------------
Date: Fri, 26 Jul 2013 13:40:03 -0400
From: Simon Marchi <simon.marchi@polymtl.ca>

> What is the difference if I do
>  --function foo
>vs
>  --probe foo
> ?

   If it follows the lttng kernel implementation, --function sets up a kret=
probe and --probe sets up a kprobe, so in user-space this should work simil=
arly: --probe sets up a function entry event while --function sets up a fun=
ction entry AND a function return event.

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
