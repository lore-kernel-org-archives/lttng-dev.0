From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: No trace files are generated for UST
Date: Fri, 6 Dec 2013 16:41:08 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267B2E2A__32910.3917153136$1386348135$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
References: <6CFA219DE9CAD940989B83CA579159F91B43ACBFBE@SGSINEXC014.vestas.net>
	<48CF5AC71E61DB46B70D0F388054EFFD267B2DCF@VAL-E-02.valcartier.drdc-rddc.gc.ca>
	<6CFA219DE9CAD940989B83CA579159F91B43ACC0B6@SGSINEXC014.vestas.net>
	<48CF5AC71E61DB46B70D0F388054EFFD267B2DF5@VAL-E-02.valcartier.drdc-rddc.gc.ca>
	<6CFA219DE9CAD940989B83CA579159F91B43ACC0C1@SGSINEXC014.vestas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VoySk-0003kn-3z
	for lttng-dev@lists.lttng.org; Fri, 06 Dec 2013 11:41:15 -0500
In-Reply-To: <6CFA219DE9CAD940989B83CA579159F91B43ACC0C1@SGSINEXC014.vestas.net>
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Manikandan Govindaswamy <magov@vestas.com>, =?iso-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

> Yes, with that LD_PRELOAD sample able to run.
>
> root@/tmp/lttng-build-root/bin # ./lttng create app
> Session app created.
> Traces will be written in /root/lttng-traces/app-20131206-174935
> root@/tmp/lttng-build-root/bin # dmesg
> root@/tmp/lttng-build-root/bin # ./lttng enable-event -u -a
> All UST events are enabled in channel channel0
> root@/tmp/lttng-build-root/bin # ./lttng start
> Tracing started for session app
> root@/tmp/lttng-build-root/bin # cd ..
> root@/tmp/lttng-build-root # cd ..
> root@/tmp # LD_PRELOAD=3D/tmp/lttng-build-root/lib/liblttng-ust.so.0 ./sa=
mple
> root@/tmp #
> root@/tmp #
> root@/tmp # cd lttng-build-root/
> root@/tmp/lttng-build-root # cd bin/
> root@/tmp/lttng-build-root/bin # ./lttng stop
> Waiting for data availability
> Tracing stopped for session app
> root@/tmp/lttng-build-root/bin # dmesg
> root@/tmp/lttng-build-root/bin # ./lttng destroy
> Session app destroyed
> root@/tmp/lttng-build-root/bin # cd /
> root@/ # cd root/
> root@~ # ls lttng-traces
> root@~ # cd lttng-traces/
> root@~/lttng-traces # ls
> root@~/lttng-traces #< no traces are generated>
>
> in ps -ef
>
> 28664 root       0:00 ./lttng-sessiond -vvv --consumerd64-path=3D/tmp/ltt=
ng-build-root/lib/lttng/libexec/lttng-consumerd
> 29027 root       0:00 lttng-consumerd --quiet -u --consumerd-cmd-sock /va=
r/run/lttng/ustconsumerd64/command --consumerd-err-sock /var/run/lttng/ustc=
onsumerd64/error

   So ./sample runs but you get no trace?  (Sound of head scratching)  Coul=
d you check 'readelf -h ./sample' and make sure the Class is ELF64?  (It's =
unlikely to be ELF32 but let's make sure anyway)

   I also thought that maybe sample being run as root is the problem, but a=
 quick check on my system shows that cannot be the case (it just traces as =
ust/uid/0).

   Interesting.  I've managed to sort-of-reproduce the problem.  If I run (=
from a user account which is NOT a tracing group member):

$ sudo -H create a
$ sudo -H enable-event -u --all
$ sudo -H start
$ ./sample
$ sudo -H destroy

   This generates the expected trace in /root/lttng-traces/a-...

   But if I do this instead:

$ sudo create a
$ sudo enable-event -u --all
$ sudo start
$ ./sample
$ sudo destroy

   Then lttng correctly creates the trace folder in /home/username/lttng-tr=
aces/a-... when sample is run, but it remains empty.  No ust sub-folder, no=
thing.

   Something is definitely awry with paths and $HOME values here.

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
Gouvernement du Canada | Government of Canada <http://www.valcartier.drdc-r=
ddc.gc.ca/>
