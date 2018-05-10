From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: No events generated for custom channel
Date: Thu, 10 May 2018 15:59:44 -0400 (EDT)
Message-ID: <1542377956.6336.1525982384912.JavaMail.zimbra__46688.2491055459$1525982274$gmane$org@efficios.com>
References: <CAC-H6tsDVpedKR0ZwtGY88Uy5JnVDibzf6V4s89SKVAEd=BMnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3714768993405957195=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 40hkbC57Y5z18bc
 for <lttng-dev@lists.lttng.org>; Thu, 10 May 2018 15:59:51 -0400 (EDT)
In-Reply-To: <CAC-H6tsDVpedKR0ZwtGY88Uy5JnVDibzf6V4s89SKVAEd=BMnQ@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Shehab Elsayed <shehabyomn@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============3714768993405957195==
Content-Type: multipart/alternative;
	boundary="=_630c5414-93a6-4a40-96db-d5b1dd496020"

--=_630c5414-93a6-4a40-96db-d5b1dd496020
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On May 10, 2018, at 2:51 PM, Shehab Elsayed <shehabyomn@gmail.com> wrote: 

> Hi All,

> I am running into a problem with creating a custom channel. It seems that once
> the total size of sub-buffers hits 512M no events are being generated.

> I tried creating a channel with 2 sub-buffers, 256M each, but when I check the
> generated traces with babeltrace , it complains that there are no valid traces.
> The same problem happens if I use a single 512M sub-buffer.

> However, If I use only 1 sub-buffer of size 256M, a trace is generated but some
> events are discarded (which I am really trying to avoid).

> I have enabled LTTNG _ UST _DEBUG and attached the output for both 2,256M and
> 1,256M cases.

> Any suggestions on how to solve this problem?

Please provide detailed commands used to setup tracing for each case. 

Which lttng components versions are you using ? 

Please provide the verbose logs of lttng-sessiond and lttng-consumerd as well. 

You should also double-check that you have enough space in /dev/shm. 

Thanks, 

Mathieu 

> Thanks,
> Shehab

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_630c5414-93a6-4a40-96db-d5b1dd496020
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On May 10, 2018, at 2:51 PM, Shehab Elsayed &lt;shehabyomn@gmail.=
com&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockq=
uote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5p=
x;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font=
-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div><=
div><div><div>Hi All,<br><br></div>I am running into a problem with creatin=
g a custom channel. It seems that once the total size of sub-buffers hits 5=
12M no events are being generated.<br><br></div>I tried creating a channel =
with 2 sub-buffers, 256M each, but when I check the generated traces with <=
span class=3D"" style=3D"" id=3D":4ng.1">babeltrace</span>, it complains th=
at there are no valid traces. The same problem happens if I use a single 51=
2M sub-buffer.<br><br></div>However, If I use only 1 sub-buffer of size 256=
M, a trace is generated but some events are discarded (which I am really tr=
ying to avoid).<br><br></div><div>I have enabled <span class=3D"" style=3D"=
" id=3D":4ng.2">LTTNG</span>_<span class=3D"" style=3D"" id=3D":4ng.3">UST<=
/span>_DEBUG and attached the output for both 2,256M and 1,256M cases.<br><=
br></div><div>Any suggestions on how to solve this problem?</div></div></bl=
ockquote><div>Please provide detailed commands used to setup tracing for ea=
ch case.<br></div><div><br data-mce-bogus=3D"1"></div><div>Which lttng comp=
onents versions are you using ?<br data-mce-bogus=3D"1"></div><div><br data=
-mce-bogus=3D"1"></div><div>Please provide the verbose logs of lttng-sessio=
nd and lttng-consumerd as well.<br data-mce-bogus=3D"1"></div><div><br data=
-mce-bogus=3D"1"></div><div>You should also double-check that you have enou=
gh space in /dev/shm.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=
=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><div><br data-mce-b=
ogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br data-m=
ce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div><br data-mce-=
bogus=3D"1"></div><blockquote style=3D"border-left:2px solid #1010FF;margin=
-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;=
text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;=
"><div dir=3D"ltr"><div><br><br></div><div>Thanks,<br></div><div><span clas=
s=3D"" style=3D"" id=3D":4ng.4">Shehab</span><br></div><div><br><br><br></d=
iv><br><div><br><br></div></div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev<br></blockquote></div><div><br></div><div data-marker=3D=
"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http=
://www.efficios.com</div></div></body></html>
--=_630c5414-93a6-4a40-96db-d5b1dd496020--

--===============3714768993405957195==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============3714768993405957195==--
