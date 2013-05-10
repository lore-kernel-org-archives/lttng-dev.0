From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: liblttng-ust finalizer oddity
Date: Fri, 10 May 2013 10:27:33 -0400
Message-ID: <20130510142733.GC20313__30763.0393458114$1368196084$gmane$org@Krystal>
References: <48CF5AC71E61DB46B70D0F388054EFFD028EF8@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UaoII-0006eZ-N7
	for lttng-dev@lists.lttng.org; Fri, 10 May 2013 10:27:34 -0400
Content-Disposition: inline
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD028EF8@VAL-E-01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "Couture,
	Mario" <Mario.Couture@drdc-rddc.gc.ca>, "Painchaud,
	Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

No idea.

Thanks,

Mathieu

* Thibault, Daniel (Daniel.Thibault@drdc-rddc.gc.ca) wrote:
>    Below is an edited-for-brevity log that highlights an oddity of the li=
blttng-ust finalizer: it triggers a load and initialization of libgcc_s, bu=
t libgcc_s's finalizer doesn't run (I checked libgcc_s.so with readelf, and=
 there is indeed a FINI entry in there).  Is this a feature of libgcc_s?  O=
f the Linux loader?  Or of LTTng?  Is it anything to worry about?
> =

> $ LD_DEBUG=3Dlibs LD_PRELOAD=3D.libs/liblttng-ust-provider-ust-tests-demo=
.so:.libs/liblttng-ust-provider-ust-tests-demo3.so ./demo
>        805:	find library=3Dlibdl.so.2 [0]; searching
>        805:	 search cache=3D/etc/ld.so.cache
>        805:	  trying file=3D/lib/x86_64-linux-gnu/libdl.so.2
>        805:	=

>        805:	find library=3Dlibc.so.6 [0]; searching
>        805:	 search cache=3D/etc/ld.so.cache
>        805:	  trying file=3D/lib/x86_64-linux-gnu/libc.so.6
>        805:	=

> [...]
>        805:	calling init: .libs/liblttng-ust-provider-ust-tests-demo.so
>        805:	=

>        805:	=

>        805:	initialize program: ./demo
>        805:	=

>        805:	=

>        805:	transferring control: ./demo
>        805:	=

> Demo program starting.
> Tracing...  done.
>        805:	=

>        805:	calling fini: ./demo [0]
>        805:	=

>        805:	=

>        805:	calling fini: .libs/liblttng-ust-provider-ust-tests-demo.so [=
0]
>        805:	=

>        805:	=

>        805:	calling fini: .libs/liblttng-ust-provider-ust-tests-demo3.so =
[0]
>        805:	=

>        805:	=

>        805:	calling fini: /lib/x86_64-linux-gnu/libdl.so.2 [0]
>        805:	=

>        805:	=

>        805:	calling fini: /home/daniel/Documents/lttng-ust-2.1.1+-08a3170=
/liblttng-ust/.libs/liblttng-ust.so.0 [0]
>        805:	=

>        805:	find library=3Dlibgcc_s.so.1 [0]; searching
>        805:	 search path=3D/home/daniel/Documents/lttng-ust-2.1.1+-08a317=
0/liblttng-ust/.libs		(RPATH from file .libs/liblttng-ust-provider-ust-test=
s-demo.so)
>        805:	  trying file=3D/home/daniel/Documents/lttng-ust-2.1.1+-08a31=
70/liblttng-ust/.libs/libgcc_s.so.1
>        805:	 search path=3D/home/daniel/Documents/lttng-ust-2.1.1+-08a317=
0/liblttng-ust/.libs		(RPATH from file .libs/liblttng-ust-provider-ust-test=
s-demo.so)
>        805:	  trying file=3D/home/daniel/Documents/lttng-ust-2.1.1+-08a31=
70/liblttng-ust/.libs/libgcc_s.so.1
>        805:	 search cache=3D/etc/ld.so.cache
>        805:	  trying file=3D/lib/x86_64-linux-gnu/libgcc_s.so.1
>        805:	=

>        805:	=

>        805:	calling init: /lib/x86_64-linux-gnu/libgcc_s.so.1
>        805:	=

>        805:	=

>        805:	calling fini: /home/daniel/Documents/lttng-ust-2.1.1+-08a3170=
/liblttng-ust/.libs/liblttng-ust-tracepoint.so.0 [0]
>        805:	=

>        805:	=

>        805:	calling fini: /lib/x86_64-linux-gnu/librt.so.1 [0]
>        805:	=

>        805:	=

>        805:	calling fini: /usr/local/lib/liburcu-bp.so.2 [0]
>        805:	=

>        805:	=

>        805:	calling fini: /usr/local/lib/liburcu-cds.so.2 [0]
>        805:	=

>        805:	=

>        805:	calling fini: /lib/x86_64-linux-gnu/libpthread.so.0 [0]
>        805:	=

> =

> Daniel U. Thibault
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R=
&D Canada - Valcartier (DRDC Valcartier)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critica=
l Cyber Security (MCCS)
> Protection des syst=E8mes et contremesures (PSC) / Systems Protection & C=
ountermeasures (SPC)
> 2459 route de la Bravoure
> Qu=E9bec, QC=A0 G3J 1X5
> CANADA
> Vox=A0: (418) 844-4000 x4245
> Fax=A0: (418) 844-4538
> NAC=A0: 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada=A0/ Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
