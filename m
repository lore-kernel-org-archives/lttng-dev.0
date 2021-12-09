Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514B4C433F5
	for <lttng-dev@archiver.kernel.org>; Thu,  9 Dec 2021 18:24:41 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4J92WC3W8bz1sD0;
	Thu,  9 Dec 2021 13:24:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1639074280;
	bh=O4oylKCYYEmaWH4kHy7gItTXN13P/+e+qH6gcK/kCaY=;
	h=Date:To:References:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=QRpRWrEkLGkhpbbFcRXGUzoqwJzuWkKpL+6vMABXWXgYZfJsGb6zaJMcn/m7sQ/hK
	 Z44YDC2/EVHax9vadnREKOcgBQAD38UHWH3RxBbpamnsQWltbu8Xe/LvoGU2mi4mYm
	 yWu+Uwm4dDoOgk+mL7ecj6HEl8w3zC1EGhkHp+Q0BjLm0+8VntZNpOm/g/GD2aA45D
	 lkp5h680cAa6DtqJe8/wEjMFDR2Hit5YWFhaR4Oi6wOnlN3HCs0t1ZBYaxV++EFBYT
	 M08F6t+fg7pSd29dLqtskFFpW9Z6ptwBxlqeo/AwmnXtHsdgfEqUWcVMQvrRtVwxhW
	 6TjqpxnhzuxjQ==
Received: from sonic313-21.consmr.mail.ir2.yahoo.com
 (sonic313-21.consmr.mail.ir2.yahoo.com [77.238.179.188])
 by lists.lttng.org (Postfix) with ESMTPS id 4J92W93g1kz1rtX
 for <lttng-dev@lists.lttng.org>; Thu,  9 Dec 2021 13:24:37 -0500 (EST)
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1639074276; bh=3Dg28Rc+q9nmnTrobpsqn4tOABHvdv8g2g3/EXgb3pl=;
 h=X-Sonic-MF:Date:From:To:Subject:From:Subject;
 b=OdnLbGSzpF6+EzHMSUOBkaZPlpxOyj/LX7a/4Dgfi0pOp/QCZ4QtMTOFnfPLRhLU6zJcZi53XWgUe1cigIO3IM7aG3ftECmTUnAzTEhkTYxA7UCp7qVe0D3sxg5aekjywk7UtURzsEgmzBWusEQUgMUpPEtAmuo6AfjlpZSqgk/3R52vwXzpQXn5Er0IMMpUWgWvfuQ+K2ByLpwS4NLVnAI2mD9U6H9bRdqjKLU3EDr0wRn/a11pnqmYm+S3guv5FLt26mI2tdNj+kBZkhnZbQYrsjOro8tIbEfcX5+qJUY3bqLpavvkBZs3mn2nYH7rDJ5eFdxRnRfk9nWSMdUwvQ==
X-YMail-OSG: GBwdKDIVM1lIX_YJBilqCV1qlh5Yb_cDyhRB_VoMOBT7U6jl6DX_N6jfkW8N_IO
 0Wg2q0hb_ZYZgpCHZX_Jb.0N0hTSPKjtFU6ocMFvm7W_rCM2pumtB4GSW.KAwKUSrkfiI9KZJSuY
 HZJJOAbl_yW3DnkyY3zb.D1Vrf5T15M8KttwiOPNIJ0HYA9vuhF9g7vA.W.18R_Z6BqpJ.MStnC0
 vaNpXCSQSkQX8tWyH8l8nssNxPutTZ8eXWscGWlkkNleGIBVNg_aMYPJzWVLRxbk_lQhm1aJgnnu
 PCX0mVOGc_mRUdvLK06ebOpJAfd.HSlyKx8MpGVp9jSV.ToJtDi8Kx9m8bFGv.fUb1q7abMTb_VO
 RSETX81NbHLQ9jDaiWX4sRdy_ZqlOKJ0I2AFZs6tJCslmLC42VoTypbYhCDyGRr6pKvzmkku_YoS
 6ngz50W4IcKH9i753P_x9ztogj_EOaBQp3VtOHqkoXjVhcWuM5_kRuebU6Sw2bVabwHF7Bf1LYXo
 LYjhQaiiiHoLhueEewh2iGL.YtQrkK5Er06KZ5CG_Ys01kUaVdcoYDqruUI0ul8hJp6i0wfmL3So
 TifCX4nUStlk37EUhfcXNmDA_soS_Q07syKxmMgS8y7tmqCp6h4.gyedVUKuBUXSKndTBDo81phj
 bGbqmbywBbukomQM0OlaB7C4HVwlBqqNZp75v_p8KMP4XwRUPv_PeKq6JV4nhu9otYiXfJr.WfTJ
 inWK9tMXTPkp7433C8fspxebrQXzjjNEPuSCfsRniWd6wrhfs_s0qOi8FX1YFCX1qfEfCPZlhBmE
 pdrfgQTlaNkOm5yQTYFYflrMDwbU3DncMQd6QpqsSOhqoAs_bzfjTPW00GvPQY_OkwRPlbw0PN8x
 8mkAgnySkNULANaf82qeFw46Ux03CP6o7RJmNm0Kvqei6ghlPzRc7d20FTBJBBVXolJRaJXc743n
 1FmL_eMYj87fJeAwckqNs7MpSx32fh9bgAILQQgJxKa8FXb32pyTmfDJ52mQDqPJkQDpsjWwSVhl
 6miCVUKY2n3BaAmB0JisaaVDHTV_AkirLOD7lIEm2hTpTXpj68IMGMcxD1CqYs4ZRwFjXBIXHEiX
 3iIHL6fhThXuYjy3nMWFtVNemYXWQYSlfiMS4swoKJ1BJjbJCwpta.Dhq2MkC2xaJNDcwVIaL38_
 nnRBm.F2mzx2q46it5WWgplzTFkd6o1JX7R6QwD.K44emKWVY8w86gd8LyrevcyIoj0YZQXmXmSD
 svFO4oe02mIesd6T8j1ZWoJ9TUkKELnAu.cjpCylUJ.lTBRJqKgVABT4MZJUowhG0WV1d8.dYIKt
 Mh7yfCryNAcrgCY..1WB85qVKvqeJnpR.hxkEIuDtPxvfkbmx0ONngfNcIYxCYPJ5iRPJwZjmLwO
 0FHz.QS07zWawhv_uSow9X_hwZN67Elyy_bGEP8ALV17LKVNntT6PH1yZPucFGUPfM0KAvNrNUFk
 eoC2TyDxiGi0SkW7g5Sen2eWx5rRRO_G5rmQNZIwaLFptwh0WV0JFqaH0gLq4rbGZn_KCL.CmdG5
 c2uT7ccSjfxyN3P9OsQRLBXmHOrpLYJgfgyZPcx5w.FrFpQ6vuOcxiDjtlONN04qRZRkemUFZIHw
 eYY5hWKG8o60IwriI0p0f380Qj81gHWN08LyZ3qP8.0HoOo1.0cl.AiwX0lYK6VMLCIGOmuD7NV_
 ddCq6.WjZuksC0MDBSNQxoX6zubNTDqrr5zWMTPJF7zbMGp1N7Dc8NVvF3n7aQa5aNcynz1TbEpF
 EU.dyt0FfgZ.haMXz8x4BYZG2GHryTSTJwF5YVQ_5Lff_pfrWxJHrp9.l4_A2MIL_Oj4SYW2XBlq
 ztbi8OPiWGlrm9kKVzi1isK3GHnXz5UZnH5FDLVeOFe.5ZQ8GyOss6y1FGDSz.wrMNpuksxZunap
 Q8FUp.TDTCVqzZuk9b0EfLgOlB7OF2CVlzDBMroKRCEvquYdc9zKYCGm2tTR9Pf3NYlvcIEcgq1g
 zBl7jwZSbKqSNEHuC5Ac.L56HH7KwCiVJwJ4p5wEGzVhOStd8ffAMzt8wUVHe07y88QhJO5744J5
 mUbTGdQLhm1NZJjBHnOWEQmldCxgUKEnEzEHNGbNBE2bWHuUg0bnGWYjc.y5IhU.izpSKIRggrJ1
 HwI.LRWvA.gAf6JOuSCsTy1BdNI9ZkDHNBYsgHSeL1H1E_31eoxIx63GtVTF5wq1xDG5pq65mrHb
 8u642YzQtL6i5EPPuOEftEVebr6uyzBcUICKDaUrhI8M7Opcr0yzvwzric8rE4eQvuPzCHbeQyZa
 hPbV4P1KyMHJt8iB1vncIMEbhOVWA1n0eIUFnXBy3wg--
X-Sonic-MF: <p_j_r_m@yahoo.com>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic313.consmr.mail.ir2.yahoo.com with HTTP; Thu, 9 Dec 2021 18:24:36 +0000
Date: Thu, 9 Dec 2021 18:24:29 +0000 (UTC)
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Message-ID: <990625985.640324.1639074269853@mail.yahoo.com>
MIME-Version: 1.0
References: <990625985.640324.1639074269853.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.19415 YahooMailAndroidMobile
Subject: [lttng-dev] Userspace lttng_logger events not shown
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.35
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: p_j_r_m via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: p_j_r_m <p_j_r_m@yahoo.com>
Content-Type: multipart/mixed; boundary="===============4903487113021816574=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============4903487113021816574==
Content-Type: multipart/alternative; 
	boundary="----=_Part_640323_560279664.1639074269852"

------=_Part_640323_560279664.1639074269852
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello
I'm a LTTNG newbie trying to write in my lttng session some "marker"=C2=A0 =
events with trace message from my program,by writing in /proc/lttng-logger =
file. But I can't see them and i don't know if they are really written in t=
he session.I do this:
lttng enable-event -k ...kernel functions here...
lttng enable-event -k --syscall -all
lttng enable-event -k lttng_logger lttng enable-event -u my_program_name:'*=
' --all

With this syntax,after the start/destroy session I can't see either syscall=
s nor my user events in Eclipse tracecompass.But I see all kernel calls per=
fectly.

Why can't I see any syscalls? Is my syntax correct?Maybe my messages are th=
ere, but tracecompass hides them for whatever reason?Thank you

------=_Part_640323_560279664.1639074269852
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div id=3D"ymail_android_signature">Hello</div><div id=3D"yMail_cursorEleme=
ntTracker_1639072665289"><br></div><div id=3D"yMail_cursorElementTracker_16=
39072665443">I'm a LTTNG newbie trying to write in my lttng session some "m=
arker"&nbsp; events with trace message from my program,by writing in /proc/=
lttng-logger file. But I can't see them and i don't know if they are really=
 written in the session.</div><div id=3D"yMail_cursorElementTracker_1639072=
944856">I do this:</div><div id=3D"yMail_cursorElementTracker_1639073254430=
"><br></div><div id=3D"yMail_cursorElementTracker_1639073270273"><span styl=
e=3D"color: rgb(36, 41, 47); font-family: ui-monospace, SFMono-Regular, &qu=
ot;SF Mono&quot;, Menlo, Consolas, &quot;Liberation Mono&quot;, monospace; =
font-size: 12px; white-space: pre;" id=3D"yMail_cursorElementTracker_163907=
3273203">lttng enable-event -k ...kernel functions here...</span><br></div>=
<div id=3D"yMail_cursorElementTracker_1639073188806"><span style=3D"color: =
rgb(36, 41, 47); font-family: ui-monospace, SFMono-Regular, &quot;SF Mono&q=
uot;, Menlo, Consolas, &quot;Liberation Mono&quot;, monospace; font-size: 1=
2px; white-space: pre;" id=3D"yMail_cursorElementTracker_1639073191638">ltt=
ng enable-event -k --syscall -all</span><br></div><div id=3D"yMail_cursorEl=
ementTracker_1639072656883"><span style=3D"color: rgb(36, 41, 47); font-fam=
ily: ui-monospace, SFMono-Regular, &quot;SF Mono&quot;, Menlo, Consolas, &q=
uot;Liberation Mono&quot;, monospace; font-size: 12px; white-space: pre;" i=
d=3D"yMail_cursorElementTracker_1639073007606">lttng enable-event -k lttng_=
logger </span></div><div id=3D"yMail_cursorElementTracker_1639073115373"><s=
pan style=3D"color: rgb(36, 41, 47); font-family: ui-monospace, SFMono-Regu=
lar, &quot;SF Mono&quot;, Menlo, Consolas, &quot;Liberation Mono&quot;, mon=
ospace; font-size: 12px; white-space: pre;" id=3D"yMail_cursorElementTracke=
r_1639073123333">lttng enable-event -u my_program_name:'*' --all</span><br>=
</div><div id=3D"yMail_cursorElementTracker_1639073314710"><br></div><div i=
d=3D"yMail_cursorElementTracker_1639072657116">With this syntax,after the s=
tart/destroy session I can't see either syscalls nor my user events in Ecli=
pse tracecompass.But I see all kernel calls perfectly.<br></div><div id=3D"=
yMail_cursorElementTracker_1639073648637"><br></div><div id=3D"yMail_cursor=
ElementTracker_1639073580333">Why can't I see any syscalls? Is my syntax co=
rrect?</div><div id=3D"yMail_cursorElementTracker_1639074032770">Maybe my m=
essages are there, but tracecompass hides them for whatever reason?</div><d=
iv id=3D"yMail_cursorElementTracker_1639074120553">Thank you</div><div id=
=3D"yMail_cursorElementTracker_1639073623373"><br></div>
------=_Part_640323_560279664.1639074269852--

--===============4903487113021816574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============4903487113021816574==--
