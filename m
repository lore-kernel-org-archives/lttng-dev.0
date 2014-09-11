From: Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: How to analysis a huge trace-collected data
 efficiently
Date: Thu, 11 Sep 2014 07:32:04 -0400 (EDT)
Message-ID: <166741422.14611521.1410435124958.JavaMail.root__2407.79664968631$1410435236$gmane$org@polymtl.ca>
References: <e4797186-ccb1-4efc-a68e-953e8575a42a@aliyun.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1522580262=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <michel.dagenais@polymtl.ca>) id 1XS2ch-0005Jl-TW
 for lttng-dev@lists.lttng.org; Thu, 11 Sep 2014 07:33:14 -0400
In-Reply-To: <e4797186-ccb1-4efc-a68e-953e8575a42a@aliyun.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1522580262==
Content-Type: multipart/alternative;
	boundary="----=_Part_14611520_455137948.1410435124957"

------=_Part_14611520_455137948.1410435124957
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Yes, if you look at the options available, you can split the trace in smaller files and even limit the total size accumulated. 

----- Mail original -----

> Hi,
> It's well known that tracing can produce huge data easily.So if we
> keep tracing on a production system for a while(hour/day/week) ,we
> may get a huge CTF file. It's very inefficient to analysis a huge
> CTF file ,especially the interested events are in some narrow time
> window.Is there any way to change the situation?Can we split a huge
> ctf file into several small ctf file? Or can lttng produce a list of
> small time-sequence ctf filles just like some loggers do?

------=_Part_14611520_455137948.1410435124957
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D'text/css'>p { margin: 0; }</style></head><body><=
div style=3D'font-family: times new roman,new york,times,serif; font-size: =
12pt; color: #000000'>Yes, if you look at the options available, you can sp=
lit the trace in smaller files and even limit the total size accumulated.<b=
r><br><hr id=3D"zwchr"><blockquote style=3D"border-left:2px solid #1010FF;m=
argin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:no=
rmal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:=
12pt;"><div class=3D"__aliyun_email_body_block"><div style=3D"color:#333333=
;font-size:14px;font-family:Tahoma,Arial,STHeiti,SimSun;;">Hi,</div><div st=
yle=3D"color:#333333;font-size:14px;font-family:Tahoma,Arial,STHeiti,SimSun=
;;">&nbsp; &nbsp;It's well known that tracing can produce huge data easily.=
So if we keep tracing on a production system for a while(hour/day/week) &nb=
sp;,we may get &nbsp;a huge CTF file. It's very inefficient to analysis a h=
uge CTF file ,especially the interested events are in some narrow time wind=
ow.Is there any way to change the situation?Can we split a huge ctf file in=
to several small ctf file? Or can lttng produce a list of small time-sequen=
ce &nbsp;ctf filles just like some loggers do?</div><div style=3D"color:#33=
3333;font-size:14px;font-family:Tahoma,Arial,STHeiti,SimSun;;"><br></div></=
div></blockquote></div></body></html>
------=_Part_14611520_455137948.1410435124957--


--===============1522580262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1522580262==--
