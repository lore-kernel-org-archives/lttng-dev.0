From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: subsys.h?
Date: Tue, 24 Sep 2013 09:28:52 -0400
Message-ID: <CA+jJMxvWQFZyr2HbHmUvGyDJqw=Emzc3boERTqFywVpCuRhw-g__31883.1004588448$1380030742$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD26792B0F@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1VOSfi-0001P6-Lt
	for lttng-dev@lists.lttng.org; Tue, 24 Sep 2013 09:29:04 -0400
Received: by mail-wi0-f178.google.com with SMTP id hn9so3852932wib.17
	for <lttng-dev@lists.lttng.org>; Tue, 24 Sep 2013 06:28:52 -0700 (PDT)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD26792B0F@VAL-E-02.valcartier.drdc-rddc.gc.ca>
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

On Tue, Sep 24, 2013 at 9:15 AM, Thibault, Daniel
<Daniel.Thibault@drdc-rddc.gc.ca> wrote:
>    In https://www.kernel.org/doc/Documentation/trace/tracepoints.txt, the=
re is prominent mention of an "include/trace/events/subsys.h".  Where is th=
at header supposed to be?  I can't find it in either of the kernel or lttng=
 sources.
>

subsys is the name of your subsystem. There is no literal subsys.h file.

J=E9r=E9mie

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
> Gouvernement du Canada | Government of Canada
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
