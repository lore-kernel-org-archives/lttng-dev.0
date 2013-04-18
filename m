From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: lttng-dev Digest, Vol 60, Issue 31
Date: Thu, 18 Apr 2013 16:15:32 -0400
Message-ID: <CA+jJMxu2FeB_xAzUg8HwKx+9A0bcfJYUqkb92qh1X1qOp8D2og__43767.9692441181$1366316168$gmane$org@mail.gmail.com>
References: <mailman.72.1366306995.2121.lttng-dev@lists.lttng.org>
	<48CF5AC71E61DB46B70D0F388054EFFD12D0EEDE@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1USvF5-0006p8-3s
	for lttng-dev@lists.lttng.org; Thu, 18 Apr 2013 16:15:39 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq17so5022124wib.5
	for <lttng-dev@lists.lttng.org>; Thu, 18 Apr 2013 13:15:33 -0700 (PDT)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD12D0EEDE@VAL-E-02.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Daniel,

The kernel modules are indeed not needed for userspace tracing.

I'm guessing you installed from source since the lttng libs don't seem
present in your path. Could tell us on which revision this is
happening?

Also, perhaps you could try Mathieu's recently commited fix? It may be
related.[1]

Regards,
J=E9r=E9mie

[1] http://lists.lttng.org/pipermail/lttng-dev/2013-April/020064.html

On Thu, Apr 18, 2013 at 3:26 PM, Thibault, Daniel
<Daniel.Thibault@drdc-rddc.gc.ca> wrote:
>>   Absolutely: no patching required.
>
>    I decided to find out if the lttng-modules were required at all if one=
 needs to do only user-space tracing.
>
>    I installed (on an otherwise lttng-virgin system) just the userspace-r=
cu, lttng-ust, and lttng-tools packages.  The lttng commands fail for the u=
sual "can't find /usr/local/lib" reason, so I need to do not:
>
> $ lttng list -u
>
>    but rather
>
> $ LD_PRELOAD=3D/usr/local/lib/liblttng-ctl.so:/usr/local/lib/liblttng-ust=
-ctl.so lttng list -u
>
>    or
>
> $ LD_LIBRARY_PATH=3D/usr/local/lib lttng list -u
>
>    However, once I made the lttng-ust/doc/examples/easy-ust sample, I get=
 a segmentation fault/core dump after starting the trace.
>
> $ LD_LIBRARY_PATH=3D/usr/local/lib lttng create usttrace
> Session usttrace created.
> Traces will be written in /home/daniel/lttng-traces/usttrace-20130418-150=
106
> $ LD_LIBRARY_PATH=3D/usr/local/lib lttng enable-event -u --all
> All UST events are enabled in channel channel0
> $ LD_LIBRARY_PATH=3D/usr/local/lib lttng start
> Tracing started for session usttrace
> $ LD_LIBRARY_PATH=3D/usr/local/lib ./sample
> Segmentation fault (core dumped)
>
>    Is this supposed to work or are the kernel modules required even when =
doing just pure user-space tracing?  I did get a partial trace on disk (jus=
t the channel0_0 and metadata files, no events in them).
>
> Daniel U. Thibault
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R=
&D Canada - Valcartier (DRDC Valcartier)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critica=
l Cyber Security (MCCS)
> Protection des syst=E8mes et contremesures (PSC) / Systems Protection & C=
ountermeasures (SPC)
> 2459 route de la Bravoure
> Qu=E9bec, QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada / Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
