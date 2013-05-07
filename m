From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: calibrate ?
Date: Mon, 6 May 2013 22:59:08 -0400
Message-ID: <20130507025908.GC24603__32193.1657883853$1367895578$gmane$org@Krystal>
References: <48CF5AC71E61DB46B70D0F388054EFFD016445@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UZY7S-0004Zc-5A
	for lttng-dev@lists.lttng.org; Mon, 06 May 2013 22:59:10 -0400
Content-Disposition: inline
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD016445@VAL-E-02.valcartier.drdc-rddc.gc.ca>
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

The calibrate function is just a rough sketch really. It could use some
more work, but it's very low priority for now.

If you feel like it, please open a feature request for this against
lttng-tools.

Thanks,

Mathieu

* Thibault, Daniel (Daniel.Thibault@drdc-rddc.gc.ca) wrote:
> I took note of http://lwn.net/Articles/492296/ (Mathieu Desnoyers, Julien=
 Desfossez, David Goulet; LTTng 2.0: Tracing for power users and developers=
 - part 2, April 18, 2012) and ran this (using the Ubuntu lttng packages th=
is time; babeltrace is 1.0.0~rc1-0ubuntu1 and lttng is 2.0.1-0ubuntu1 [libl=
ttng-ctl0, lttng-tools] and 2.0.2-0ubuntu1 [liblttng-ust0, lttng-modules-dk=
ms]):
> =

> $ sudo -H lttng create calibrate-session
> Session calibrate-session created.
> Traces will be written in /root/lttng-traces/calibrate-session-20130213-1=
43220
> $ sudo -H lttng enable-event calibrate-event -k --function lttng_calibrat=
e_kretprobe
> kernel event calibrate-event created in channel channel0
> $ sudo -H lttng add-context -k -t perf:LLC-load-misses -t perf:LLC-store-=
misses -t perf:LLC-prefetch-misses
> Error: perf:LLC-prefetch-misses: Add kernel context failed
> kernel context perf:LLC-store-misses added to all channels
> kernel context perf:LLC-load-misses added to all channels
> Warning: Some command(s) went wrong
> $ sudo -H lttng start
> Tracing started for session calibrate-session
> $ for a in $(seq 1 10); do \
> > sudo -H lttng calibrate -k --function; \
> > done
> Kernel calibration done
> Kernel calibration done
> Kernel calibration done
> Kernel calibration done
> Kernel calibration done
> Kernel calibration done
> Kernel calibration done
> Kernel calibration done
> Kernel calibration done
> Kernel calibration done
> $ sudo -H lttng destroy
> Session calibrate-session destroyed at /root
> $ sudo -H babeltrace /root/lttng-traces/calibrate-session-20130213-143220
> error syntax error
> [error] Error creating AST
> [warning] Unable to open trace metadata for path "/root/lttng-traces/cali=
brate-session-20130213-143220/kernel".
> [warning] [Context] Cannot open_trace of the format /root/lttng-traces/ca=
librate-session-20130213-143220/kernel .
> =

> [warning] [Context] opening trace "/root/lttng-traces/calibrate-session-2=
0130213-143220/kernel" from /root/lttng-traces/calibrate-session-20130213-1=
43220 for reading.
> =

> ##########
> Now, the "Error: perf:LLC-prefetch-misses: Add kernel context failed" is =
probably because 'dmesg | grep "generic r"' reports just two generic regist=
ers, although it seems odd the error would occur on the first context attem=
pt and not the last.
> =

> My real problem is with the trace thus generated and babeltrace's handlin=
g of it.  It consists of five files: metadata and channel0_0 through channe=
l0_3.  There is no kernel file.
> =

> I moved the trace to another machine and tried a more up-to-date babeltra=
ce (babeltrace-1.0.3+-217b52c), with little difference:
> =

> error syntax error
> [error] Error creating AST
> [warning] Unable to open trace metadata for path "/home/daniel/lttng-trac=
es/calibrate-session-20130213-143220/kernel".
> [warning] [Context] Cannot open_trace of format ctf at path /home/daniel/=
lttng-traces/calibrate-session-20130213-143220/kernel.
> =

> [warning] [Context] cannot open trace "/home/daniel/lttng-traces/calibrat=
e-session-20130213-143220/kernel" from /home/daniel/lttng-traces/calibrate-=
session-20130213-143220 for reading.
> [error] Cannot open any trace for reading.
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
