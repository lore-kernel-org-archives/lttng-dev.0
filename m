From: Zvi Vered <veredz72@gmail.com>
Subject: (no subject)
Date: Thu, 13 Jun 2019 06:17:38 +0300
Message-ID: <CABRndgyzXQaYpefcMEMt1ShbqVKaf9vLJOXaL2cgUZMik4=xxw__36008.7614551716$1560396134$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6338260373122322815=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 by lists.lttng.org (Postfix) with ESMTPS id 45PTYd3D5Rz186j
 for <lttng-dev@lists.lttng.org>; Wed, 12 Jun 2019 23:21:57 -0400 (EDT)
Received: by mail-yb1-xb34.google.com with SMTP id p8so7202268ybo.13
 for <lttng-dev@lists.lttng.org>; Wed, 12 Jun 2019 20:21:57 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============6338260373122322815==
Content-Type: multipart/alternative; boundary="0000000000003a8066058b2c08e1"

--0000000000003a8066058b2c08e1
Content-Type: text/plain; charset="UTF-8"

Hello,

I'm trying to read the file "metadata".
I read the struct:

struct metadata_packet_header {
uint32_t magic; /* 0x75D11D57 */
uint8_t  uuid[16]; /* Unique Universal Identifier */
uint32_t checksum; /* 0 if unused */
uint32_t content_size; /* in bits */
uint32_t packet_size; /* in bits */
uint8_t  compression_scheme; /* 0 if unused */
uint8_t  encryption_scheme; /* 0 if unused */
uint8_t  checksum_scheme; /* 0 if unused */
uint8_t  major; /* CTF spec major version number */
uint8_t  minor; /* CTF spec minor version number */
HEADER_END;
};

the magic is indeed 0x75D11D57.
What is next struct I should read ?
I would expect "packet context". Am I right ?
what struct is it ?

I want to write a simple babeltrace for windows.
If I succeed, and you will find it relevant, I can upload this project.

Thank you in advance,
Zvika

--0000000000003a8066058b2c08e1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<br><div><br></div><div>I&#39;m trying to read the f=
ile &quot;metadata&quot;.</div><div>I read the struct:=C2=A0</div><div><br>=
</div><div>struct metadata_packet_header {<br>	uint32_t magic;			/* 0x75D11=
D57 */<br>	uint8_t =C2=A0uuid[16];		/* Unique Universal Identifier */<br>	u=
int32_t checksum;		/* 0 if unused */<br>	uint32_t content_size;		/* in bits=
 */<br>	uint32_t packet_size;		/* in bits */<br>	uint8_t =C2=A0compression_=
scheme;	/* 0 if unused */<br>	uint8_t =C2=A0encryption_scheme;	/* 0 if unus=
ed */<br>	uint8_t =C2=A0checksum_scheme;	/* 0 if unused */<br>	uint8_t =C2=
=A0major;			/* CTF spec major version number */<br>	uint8_t =C2=A0minor;			=
/* CTF spec minor version number */<br>	HEADER_END;<br>};<br></div><div><br=
></div><div>the magic is indeed 0x75D11D57.</div><div>What is next struct I=
 should read ?</div><div>I would expect &quot;packet context&quot;. Am I ri=
ght ?=C2=A0</div><div>what struct is it ?</div><div><br></div><div>I want t=
o write a simple babeltrace for windows.=C2=A0</div><div>If I succeed, and =
you will find it relevant, I can upload this project.=C2=A0</div><div><br><=
/div><div>Thank you in=C2=A0advance,</div><div>Zvika=C2=A0</div></div>

--0000000000003a8066058b2c08e1--

--===============6338260373122322815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6338260373122322815==--
