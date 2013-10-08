From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Sub-buffer multiplicity on multi-core systems
Date: Tue, 8 Oct 2013 17:57:23 -0400
Message-ID: <CA+jJMxsNG7BQ4Br-Mxth+KB=80GJg5h2Yv+2sY0P7eX3xwRCmw__43587.6153795563$1381269507$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD2679BE23@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-we0-f170.google.com ([74.125.82.170])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1VTfHV-0005SV-Rb
	for lttng-dev@lists.lttng.org; Tue, 08 Oct 2013 17:57:35 -0400
Received: by mail-we0-f170.google.com with SMTP id u57so8905213wes.29
	for <lttng-dev@lists.lttng.org>; Tue, 08 Oct 2013 14:57:23 -0700 (PDT)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD2679BE23@VAL-E-01.valcartier.drdc-rddc.gc.ca>
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

On Mon, Oct 7, 2013 at 5:28 PM, Thibault, Daniel
<Daniel.Thibault@drdc-rddc.gc.ca> wrote:
>    I understand that each processor can be understood as generating its o=
wn event stream (for a given event).  Assume a quad-core system.  At which =
point are the four event streams merged into one?  What I mean is: is the r=
ing buffer which represents a kernel channel for a given session (for examp=
le) actually four ring buffers (one per CPU), or just one?  I suspect the m=
erge occurs early (at the LTTng kernel module level), but I want to be sure=
.  (I understand that the four streams remain distinct in the logical CTF s=
ense: what I'm wondering about here is the sub-buffer multiplicity)
>

In kernel tracing, ring buffers are separate per CPU, per channel.
Each ring buffer is flushed into its own CTF data stream file. These
streams are only "merged" by Babeltrace (or any other reader) while
reading the trace.

Regards,
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
