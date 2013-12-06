From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: No trace files are generated for UST
Date: Fri, 6 Dec 2013 14:44:41 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267B2DAE__30569.2744827413$1386341148$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
References: <6CFA219DE9CAD940989B83CA579159F91B43ACBFBE@SGSINEXC014.vestas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1Vowe2-0002o6-If
	for lttng-dev@lists.lttng.org; Fri, 06 Dec 2013 09:44:46 -0500
In-Reply-To: <6CFA219DE9CAD940989B83CA579159F91B43ACBFBE@SGSINEXC014.vestas.net>
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

> De=A0: Manikandan Govindaswamy [mailto:magov@vestas.com] =

> Envoy=E9=A0: 6 d=E9cembre 2013 04:49
>
> Now I'm trying with ust examples : demo and easy-ust and I'm facing the s=
ame problem of no tracing is generated.
>
> Please find the sessiond log and the execution sequence as below for samp=
le.
>
> I tried the same for demo and it looks the same behaviour
>
> root@/tmp/lttng-build-root/bin # ./lttng create
> Session auto-20131206-113744 created.
> Traces will be written in /root/lttng-traces/auto-20131206-113744
> root@/tmp/lttng-build-root/bin # ./lttng enable-event -u --all
> All UST events are enabled in channel channel0
> root@/tmp/lttng-build-root/bin # ./lttng start
> Tracing started for session auto-20131206-113744
> root@/tmp/lttng-build-root/bin # cd ../../
> root@/tmp # ./sample
> root@/tmp # cd - /tmp/lttng-build-root/bin
> root@/tmp/lttng-build-root/bin # ./lttng stop
> Waiting for data availability
> Tracing stopped for session auto-20131206-113744
> root@/tmp/lttng-build-root/bin # ./lttng destroy
> Session auto-20131206-113744 destroyed
> root@/tmp/lttng-build-root/bin # cd /
> root@/ # cd root/
> root@~ # ls lttng-traces
> root@~ # cd lttng-traces/
> root@~/lttng-traces # ls
> test-20131205-180744
> root@~/lttng-traces #

   That works fine on my system.  You sure lttng-traces/test-20131205-18074=
4 has an empty ust/uid/1000/64-bit/channel0_0 file?

   Did you 'make install' lttng-ust?  liblttng-ust must be in the $PATH, so=
 try to run sample like this during the session:

$ LD_PRELOAD=3D/usr/local/lib/liblttng-ust ./sample

   Otherwise, we'll take a look at the output of the make.  In lttng-ust/do=
c/examples/easy-ust:

$ gcc -I. -c -o tp.o -x c -D TRACEPOINT_CREATE_PROBES sample_component_prov=
ider.h
$ gcc -I. -c -o sample.o sample.c
$ gcc -o sample sample.o tp.o -ldl -llttng-ust

   (Here I chose to skip tp.c entirely: '-x c -D TRACEPOINT_CREATE_PROBES s=
ample_component_provider.h' is equivalent to 'tp.c' in the tp.o gcc line)

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
[Valcartier]\\vsi-wdut-o980, [Valcartier]\\edge
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
