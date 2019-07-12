From: Ravindra Kumar Meena <rmeena840@gmail.com>
Subject: Need help with CTF
Date: Fri, 12 Jul 2019 11:33:39 +0530
Message-ID: <CAEWVvOQHcvj3A=8Rufusv9Ti3aF=+yR4ZqWQFc-DpOvgVZUfvg__14861.2014063232$1576308116$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0485475925114681030=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by lists.lttng.org (Postfix) with ESMTPS id 45lMnb1JP5z18Jc
 for <lttng-dev@lists.lttng.org>; Fri, 12 Jul 2019 02:04:19 -0400 (EDT)
Received: by mail-wr1-x42a.google.com with SMTP id g17so8605717wrr.5
 for <lttng-dev@lists.lttng.org>; Thu, 11 Jul 2019 23:04:18 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0485475925114681030==
Content-Type: multipart/alternative; boundary="0000000000003af37b058d75aeb4"

--0000000000003af37b058d75aeb4
Content-Type: text/plain; charset="UTF-8"

Hi developers,

trace {
    major = 1;
    minor = 8;
    uuid = "6a7715d0-b502-4c65-8678-6777ac7f755a";
    byte_order = le;
    packet.header := struct {
        uint32_t magic;
        uint8_t  uuid[16];
        uint32_t stream_id;
        uint64_t stream_instance_id;
    };
};

In the above what does stream_instance_id does? In CTF documentation [1] it
looks like packet.header can contain three values(magic, uuid, stream_id)
then what is stream_instance_id?

Please attend this ASAP

Thanks

-- 
*Ravindra Kumar Meena*,
B. Tech. Computer Science and Engineering,
Indian Institute of Technology (Indian School of Mines)
<https://www.iitism.ac.in/>, Dhanbad

--0000000000003af37b058d75aeb4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi developers,<div><br></div><div>trace {<br>=C2=A0 =C2=A0=
 major =3D 1;<br>=C2=A0 =C2=A0 minor =3D 8;<br>=C2=A0 =C2=A0 uuid =3D &quot=
;6a7715d0-b502-4c65-8678-6777ac7f755a&quot;;<br>=C2=A0 =C2=A0 byte_order =
=3D le;<br>=C2=A0 =C2=A0 packet.header :=3D struct {<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 uint32_t magic;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t =C2=A0uui=
d[16];<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t stream_id;<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 uint64_t stream_instance_id;<br>=C2=A0 =C2=A0 };<br>};</div><=
div><br></div><div>In the above what does stream_instance_id does? In CTF d=
ocumentation [1] it looks like packet.header can contain three values(magic=
, uuid, stream_id) then what is stream_instance_id?</div><div><br></div><di=
v>Please attend this ASAP</div><div><br></div><div>Thanks<br clear=3D"all">=
<div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature" data-smart=
mail=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><font size=
=3D"4"><b>Ravindra Kumar Meena</b></font>,<div><span style=3D"color:rgb(102=
,102,102)">B. Tech. Computer Science and Engineering,<br></span></div><div>=
<span style=3D"color:rgb(102,102,102)"><a href=3D"https://www.iitism.ac.in/=
" style=3D"color:rgb(17,85,204)" target=3D"_blank">Indian Institute of Tech=
nology (Indian School of Mines)</a>, Dhanbad</span></div></div></div></div>=
</div></div></div>

--0000000000003af37b058d75aeb4--

--===============0485475925114681030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0485475925114681030==--
