From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Updated easy-ust Makefile
Date: Wed, 15 May 2013 17:02:49 -0400
Message-ID: <CA+jJMxt6Hf-EO-B2ZJ3ZJa3hyQB=iuGHGNm1b3mqw5o2aLsnoA__34870.3516684056$1368651806$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD028E81@VAL-E-01.valcartier.drdc-rddc.gc.ca>
	<20130510142534.GB20313@Krystal>
	<48CF5AC71E61DB46B70D0F388054EFFD12D17FE9@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1Uciqd-0000ZN-J0
	for lttng-dev@lists.lttng.org; Wed, 15 May 2013 17:02:55 -0400
Received: by mail-wi0-f181.google.com with SMTP id hi5so2080266wib.14
	for <lttng-dev@lists.lttng.org>; Wed, 15 May 2013 14:02:49 -0700 (PDT)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD12D17FE9@VAL-E-02.valcartier.drdc-rddc.gc.ca>
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
	Mario" <Mario.Couture@drdc-rddc.gc.ca>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Painchaud,
	Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

I'd prefer we keep documentation as distribution-agnostic as possible;
that includes example Makefiles. It's not unreasonable to expect users
to install the libraries in a location that is part of their library
path.

Regards,
J=E9r=E9mie

On Wed, May 15, 2013 at 4:34 PM, Thibault, Daniel
<Daniel.Thibault@drdc-rddc.gc.ca> wrote:
> -----Message d'origine-----
> De : Mathieu Desnoyers [mailto:mathieu.desnoyers@efficios.com]
> Envoy=E9 : 10 mai 2013 10:26
>
>> Every problem related to your distribution not having /usr/local/lib in =
ld.so.conf by default should be handled by adding documentation to the proj=
ect, not modifying makefiles.
>>
>> Jeremie will take care of adding this info to the documentation.
>
>    My understanding is that adding ' LDFLAGS =3D -L/usr/local/lib' to the=
 compilation calls will make no difference on distributions that do include=
 /usr/local/lib by default.  Ubuntu does not, so it needs that LDFLAGS in o=
rder for its unmodified makefile to succeed.  Since this simple addition br=
eaks no other distro (as far as I know), why not make lttng-ust/doc/example=
s/easy-ust more inclusive?
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
> Gouvernement du Canada | Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
