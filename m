From: Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: Merge two LTTng CTF traces into one
Date: Mon, 22 Dec 2014 08:07:40 -0500 (EST)
Message-ID: <1431870336.8158578.1419253660346.JavaMail.root__13088.6995503262$1419253704$gmane$org@polymtl.ca>
References: <CA+=dQ--QY6zW4m-V-tQFP6DGFH=jsyrR6SPnhfLxq3H5LJg4HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2045065367=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <michel.dagenais@polymtl.ca>) id 1Y32i5-000514-K4
 for lttng-dev@lists.lttng.org; Mon, 22 Dec 2014 08:07:42 -0500
In-Reply-To: <CA+=dQ--QY6zW4m-V-tQFP6DGFH=jsyrR6SPnhfLxq3H5LJg4HQ@mail.gmail.com>
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

--===============2045065367==
Content-Type: multipart/alternative;
	boundary="----=_Part_8158577_2124186352.1419253660345"

------=_Part_8158577_2124186352.1419253660345
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Normally, the two traces are stored separately and they are "merged" at display time in TraceCompass. If they were taken on the same host, they use the same clock and should be naturally aligned. If they come from different hosts and you want very fine symchronization, you need some communication events from which to synchronize the traces. TCP packet send and receive events are typically used. If you want to look at two traces simultaneously, it normally implies that the two are related, the two nodes communicating through the network. 

----- Mail original -----

> Hi,

> Is there any way to merge the two CTF traces and see them in one with
> trace synchronization ?

> How it is related to trace synchronization using network events ?

> Thanks,
> Divya
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

------=_Part_8158577_2124186352.1419253660345
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D'text/css'>p { margin: 0; }</style></head><body><=
div style=3D'font-family: times new roman,new york,times,serif; font-size: =
12pt; color: #000000'>Normally, the two traces are stored separately and th=
ey are "merged" at display time in TraceCompass. If they were taken on the =
same host, they use the same clock and should be naturally aligned. If they=
 come from different hosts and you want very fine symchronization, you need=
 some communication events from which to synchronize the traces. TCP packet=
 send and receive events are typically used. If you want to look at two tra=
ces simultaneously, it normally implies that the two are related, the two n=
odes communicating through the network.<br><br><hr id=3D"zwchr"><blockquote=
 style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;co=
lor:#000;font-weight:normal;font-style:normal;text-decoration:none;font-fam=
ily:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr">Hi,<div><b=
r></div><div>Is there any way to merge the two CTF traces and see them in o=
ne with trace synchronization ?&nbsp;</div><div><br></div><div>How it is re=
lated to trace synchronization using network events ?&nbsp;</div><div><br><=
/div><div><br></div><div>Thanks,</div><div>Divya</div></div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>http://lists.lttng.org/cgi-bin/mailman/l=
istinfo/lttng-dev<br></blockquote><br></div></body></html>
------=_Part_8158577_2124186352.1419253660345--


--===============2045065367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2045065367==--
