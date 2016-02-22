From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Deleting files from log folder
Date: Mon, 22 Feb 2016 20:13:38 +0000 (UTC)
Message-ID: <1073734840.4597.1456172018476.JavaMail.zimbra__6213.35481196201$1456172087$gmane$org@efficios.com>
References: <CAD6O9ape7M-VKs+H4uhcQevGvAMRGSEa4CoXUC7A9HRdJpNesQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2093207954=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1aXwrZ-00011f-Qw
 for lttng-dev@lists.lttng.org; Mon, 22 Feb 2016 15:13:46 -0500
In-Reply-To: <CAD6O9ape7M-VKs+H4uhcQevGvAMRGSEa4CoXUC7A9HRdJpNesQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: syed zaidi <zaidi1039@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============2093207954==
Content-Type: multipart/alternative;
	boundary="----=_Part_4596_1421363052.1456172018475"

------=_Part_4596_1421363052.1456172018475
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Feb 18, 2016, at 7:05 PM, syed zaidi <zaidi1039@gmail.com> wrote: 

> Hey guys,
> I am new to using LTTng.
> My question is that, if I want to delete/move some binary log files produced by
> LTTng, do I have to delete/move the corresponding ".idx" file from the index
> folder too?
> I am looking for the correct way to move log files from the folder.
> I would really appreciate if someone could guide me on that and please let me
> know if I am overlooking any issue in terms of moving the files.

Hi, 

Yes, deleting both stream files and associated .idx files seems like a 
good way to proceed in your case. 

Thanks, 

Mathieu 

> Thanks
> Ammar

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_4596_1421363052.1456172018475
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Feb 18, 2016, at 7:05 PM, syed zaidi &lt;zaidi1039@gmail.com&g=
t; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockquote =
style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;col=
or:#000;font-weight:normal;font-style:normal;text-decoration:none;font-fami=
ly:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr">Hey guys,<d=
iv>I am new to using LTTng.&nbsp;</div><div>My question is that, if I want =
to delete/move some binary log files produced by LTTng, do I have to delete=
/move the corresponding ".idx" file from the index folder too?</div><div>I =
am looking for the correct way to move log files from the folder.</div><div=
>I would really appreciate if someone could guide me on that and please let=
 me know if I am overlooking any issue in terms of moving the files.</div><=
/div></blockquote><div><br></div><div>Hi,<br data-mce-bogus=3D"1"></div><di=
v><br data-mce-bogus=3D"1"></div><div>Yes, deleting both stream files and a=
ssociated .idx files seems like a<br data-mce-bogus=3D"1"></div><div>good w=
ay to proceed in your case.<br data-mce-bogus=3D"1"></div><div><br data-mce=
-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><div><br data=
-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br =
data-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2px solid #1010=
FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-styl=
e:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-s=
ize:12pt;"><div dir=3D"ltr"><br><div>Thanks</div><div>Ammar</div></div><br>=
_______________________________________________<br>lttng-dev mailing list<b=
r>lttng-dev@lists.lttng.org<br>http://lists.lttng.org/cgi-bin/mailman/listi=
nfo/lttng-dev<br></blockquote></div><div><br></div><div data-marker=3D"__SI=
G_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://ww=
w.efficios.com</div></div></body></html>
------=_Part_4596_1421363052.1456172018475--


--===============2093207954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2093207954==--
