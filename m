From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: 32-bit application crash
Date: Mon, 10 Aug 2015 15:51:51 +0000 (UTC)
Message-ID: <2057313186.17698.1439221911920.JavaMail.zimbra__42069.1196261489$1439221977$gmane$org@efficios.com>
References: <CAM5kDqx75WqM7E8JoL-bmxfoXFNwsXzxyq0216ew3fnE8Y10Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0102229295=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZOpMs-0000Xw-4f
 for lttng-dev@lists.lttng.org; Mon, 10 Aug 2015 11:52:08 -0400
In-Reply-To: <CAM5kDqx75WqM7E8JoL-bmxfoXFNwsXzxyq0216ew3fnE8Y10Vg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Anand Neeli <anand.neeli@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, jamie explorer <jamieexplorer@gmail.com>
List-Id: lttng-dev@lists.lttng.org

--===============0102229295==
Content-Type: multipart/alternative;
	boundary="----=_Part_17697_34243766.1439221911920"

------=_Part_17697_34243766.1439221911920
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Aug 10, 2015, at 11:34 AM, Anand Neeli <anand.neeli@gmail.com> wrote: 

> Hi Jam,
> You might be seeing this crash as c++ support may not there for tracepoint
> probes.
> Seen this note while going through bugfixes in 2.7
> https://github.com/lttng/lttng-ust/commit/c87d0ff28731aa18660cbb076e69ed7677dea3d2

> "- Note for C++ support: although an application instrumented with
>    tracepoints can be compiled with g++, tracepoint probes should be
>    compiled with gcc (only tested with gcc so far)."
> But you are seeing this only when using g++ with 32-bit apps. 64-bit apps
> compiled g++ dont crash.
> Would be good if experts comment here.

Hi Anand (a.k.a. Jamie), 

Experts would comment this: 

1) It is not a good practice to reply to yourself through two email accounts on 
lttng-dev. 

2) You have been repeatedly told that you appear to need enterprise level support 
for the kind of questions you are asking. But instead of following this advice, 
you now post from a pseudonym. 

I restate the recommendation about asking EfficiOS for LTTng enterprise 
support. 

Thank you, 

Mathieu 

> Thanks,
> Anand Neeli

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_17697_34243766.1439221911920
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Aug 10, 2015, at 11:34 AM, Anand Neeli &lt;anand.neeli@gmail.c=
om&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockqu=
ote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px=
;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font-=
family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr">Hi Jam,=
<br><div>You might be seeing this crash as c++ support may not there for tr=
acepoint probes.</div><div>Seen this note while going through bugfixes &nbs=
p;in 2.7</div><div><a href=3D"https://github.com/lttng/lttng-ust/commit/c87=
d0ff28731aa18660cbb076e69ed7677dea3d2" target=3D"_blank">https://github.com=
/lttng/lttng-ust/commit/c87d0ff28731aa18660cbb076e69ed7677dea3d2</a><br></d=
iv><br><div><pre style=3D"overflow:visible;font-family:Consolas,'Liberation=
 Mono',Menlo,Courier,monospace;font-size:13px;margin-top:10px;margin-bottom=
:10px;font-stretch:normal;line-height:1.45;max-width:100%;color:rgb(89,96,9=
9);white-space:pre-wrap;word-wrap:break-word;background-color:rgb(230,241,2=
46)">"- Note for C++ support: although an application instrumented with
   tracepoints can be compiled with g++, tracepoint probes should be
   compiled with gcc (only tested with gcc so far)."</pre><div>But you are =
seeing this only when using g++ with 32-bit apps. 64-bit apps compiled g++ =
dont crash.</div><div>Would be good if experts comment here.</div></div></d=
iv></blockquote><div>Hi Anand (a.k.a. Jamie),<br data-mce-bogus=3D"1"></div=
><div><br data-mce-bogus=3D"1"></div><div>Experts would comment this:<br></=
div><div><br data-mce-bogus=3D"1"></div><div>1) It is not a good practice t=
o reply to yourself through two email accounts on<br data-mce-bogus=3D"1"><=
/div><div>lttng-dev.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=
=3D"1"></div><div>2) You have been repeatedly told that you appear to need =
enterprise level support<br data-mce-bogus=3D"1"></div><div>for the kind of=
 questions you are asking. But instead of following this advice,<br data-mc=
e-bogus=3D"1"></div><div>you now post from a pseudonym.<br data-mce-bogus=
=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>I restate the recomme=
ndation about asking EfficiOS for LTTng enterprise</div><div>support.<br da=
ta-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Thank you=
,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Ma=
thieu</div><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"border-=
left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-wei=
ght:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Ari=
al,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div><br>Thanks,<br>Anand N=
eeli</div></div><br></blockquote></div><div><br></div><div data-marker=3D"_=
_SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http:/=
/www.efficios.com</div></div></body></html>
------=_Part_17697_34243766.1439221911920--


--===============0102229295==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0102229295==--
