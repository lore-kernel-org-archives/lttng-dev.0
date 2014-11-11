From: =?ISO-8859-1?Q?Rapha=EBl_Beamonte?= <raphael.beamonte@gmail.com>
Subject: Re: babeltrace CTF -> Text -> CTF
Date: Tue, 11 Nov 2014 00:33:19 -0500
Message-ID: <CAE_Gge14wobmw8n1MsuXnfpS2eDtC4s=3tqGSEO+agAzY2nqJg__953.601269475435$1415684060$gmane$org@mail.gmail.com>
References: <CA+=dQ-9JigPHaP=_u8kBYQ4vWGGUowY7YsWwPjyZfVxaMjYuKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <nashii@gmail.com>) id 1Xo45J-0004cU-Et
 for lttng-dev@lists.lttng.org; Tue, 11 Nov 2014 00:33:47 -0500
Received: by mail-pa0-f52.google.com with SMTP id fa1so9900924pad.39
 for <lttng-dev@lists.lttng.org>; Mon, 10 Nov 2014 21:33:39 -0800 (PST)
In-Reply-To: <CA+=dQ-9JigPHaP=_u8kBYQ4vWGGUowY7YsWwPjyZfVxaMjYuKA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Divya Vyas <dvyas@mvista.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Divya,

2014-11-11 0:27 GMT-05:00 Divya Vyas <dvyas@mvista.com>:
> The text_output first line is
>
> [12:44:05.438190693] (+?.?????????) kmem_cache_alloc: { cpu_id =3D 0 }, {
> call_site =3D 0xFFFFFFFF811806FC, ptr =3D 0xFFFF8800157248C0, bytes_req =
=3D 304,
> bytes_alloc =3D 320, gfp_flags =3D 32976 }
>
> missing timestamp

The timestamp is here: 12:44:05.438190693
The "+?.?????????" part represents the time difference between the
previous event and this one, but as it is the first event of the
trace, there isn't any previous event, thus leading to the
"+?.?????????".

Rapha=EBl
