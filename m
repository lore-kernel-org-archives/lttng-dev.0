From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: No trace files are generated for UST
Date: Fri, 6 Dec 2013 12:52:34 -0500
Message-ID: <CA+jJMxt-D9CEFVhH93Q7iy=0W1KRsynBA9is-AP3L0+Dpq11Cg__5044.04671160064$1386352422$gmane$org@mail.gmail.com>
References: <6CFA219DE9CAD940989B83CA579159F91B43ACBFBE@SGSINEXC014.vestas.net>
	<48CF5AC71E61DB46B70D0F388054EFFD267B2DCF@VAL-E-02.valcartier.drdc-rddc.gc.ca>
	<6CFA219DE9CAD940989B83CA579159F91B43ACC0B6@SGSINEXC014.vestas.net>
	<48CF5AC71E61DB46B70D0F388054EFFD267B2DF5@VAL-E-02.valcartier.drdc-rddc.gc.ca>
	<6CFA219DE9CAD940989B83CA579159F91B43ACC0C1@SGSINEXC014.vestas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1VozZw-0004Ml-DO
	for lttng-dev@lists.lttng.org; Fri, 06 Dec 2013 12:52:46 -0500
Received: by mail-qc0-f170.google.com with SMTP id x13so729868qcv.15
	for <lttng-dev@lists.lttng.org>; Fri, 06 Dec 2013 09:52:35 -0800 (PST)
In-Reply-To: <6CFA219DE9CAD940989B83CA579159F91B43ACC0C1@SGSINEXC014.vestas.net>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Manikandan Govindaswamy <magov@vestas.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "Thibault,
	Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

Could you launch the session daemon in verbose mode and post the logs?

lttng-sessiond -vvv --verbose-consumer

On Fri, Dec 6, 2013 at 10:51 AM, Manikandan Govindaswamy
<magov@vestas.com> wrote:
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
> root@~ # ls
> lttng-traces
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
>
> Regards,
> GMK.
>
>
>
> -----Original Message-----
> From: Thibault, Daniel [mailto:Daniel.Thibault@drdc-rddc.gc.ca]
> Sent: Friday, December 06, 2013 9:14 PM
> To: Manikandan Govindaswamy; J=E9r=E9mie Galarneau
> Cc: lttng-dev@lists.lttng.org
> Subject: RE: [lttng-dev] No trace files are generated for UST
>
>> As I'm using the custom image on x86 machine, i've kept the lib in /tmp/=
lttng-build-root/lib folder and this sample able to see the library as well.
>>
>> And the same way I able to create the trace files for kernel but not for=
 ust. There were no dmesg as well.
>>
>> [...]
>> root@/tmp # ldd sample
>>         linux-vdso.so.1 (0x00007fff2a135000)
>>         libdl.so.2 =3D> /lib64/libdl.so.2 (0x00007fe2cccb5000)
>>         liblttng-ust.so.0 =3D> /tmp/lttng-build-root/lib/liblttng-ust.so=
.0 (0x00007fe2cca51000)
>>         [...]
>
>    Try running sample using:
>
> LD_PRELOAD=3D/tmp/lttng-build-root/lib/liblttng-ust.so.0 ./sample
>
>    If the LD_PRELOAD succeeds, we will know at least that liblttng-ust is=
 reachable by sample.
>
>    The modules have nothing to do with UST: kernel and user-space tracing=
 are essentially independent features.
>
> Daniel U. Thibault
> Protection des syst=E8mes et contremesures (PSC) | Systems Protection & C=
ountermeasures (SPC)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critica=
l Cyber Security (MCCS)
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R=
&D Canada - Valcartier (DRDC Valcartier)
> 2459 route de la Bravoure
> Qu=E9bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada | Government of Canada <http://www.valcartier.drdc=
-rddc.gc.ca/>



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
