From: Yonghong Yan <yanyh15@gmail.com>
Subject: add cpu_id context to the channel
Date: Mon, 21 Jan 2019 12:14:06 -0500
Message-ID: <CACJEY86QpFpjiDe_eHfCnpEhRRPgsfW-+xW5LdM=xRFWNgOL-Q__16696.9695988641$1548090869$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8135857019339486589=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 by lists.lttng.org (Postfix) with ESMTPS id 43jyp32hZRzp72
 for <lttng-dev@lists.lttng.org>; Mon, 21 Jan 2019 12:14:19 -0500 (EST)
Received: by mail-pg1-x533.google.com with SMTP id w6so9747036pgl.6
 for <lttng-dev@lists.lttng.org>; Mon, 21 Jan 2019 09:14:19 -0800 (PST)
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

--===============8135857019339486589==
Content-Type: multipart/alternative; boundary="0000000000009e5879057ffafd36"

--0000000000009e5879057ffafd36
Content-Type: text/plain; charset="UTF-8"

I saw there is cpu_id field in babeltrace list, how can I add it to the
context of UST tracepoint events. lttng add-context --list does not show
that field and I do not see a similar field for the cpu_id.

Thank you
Yonghong

--0000000000009e5879057ffafd36
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">I saw there is cpu_id field in babeltrace=
 list, how can I add it to the context of UST tracepoint events.=C2=A0lttng=
 add-context --list does not show that field and I do not see a similar fie=
ld for the cpu_id.=C2=A0</div><div dir=3D"ltr"><br></div><div>Thank you</di=
v><div>Yonghong</div></div>

--0000000000009e5879057ffafd36--

--===============8135857019339486589==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8135857019339486589==--
