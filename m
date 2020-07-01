From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re:
 =?utf-8?b?5Zue5aSN77yaIOWbnuWkje+8miBzb21lIHRyYWNl?=
 =?utf-8?q?points_not_exist_in_metadata=3F?=
Date: Wed, 1 Jul 2020 08:07:20 -0400 (EDT)
Message-ID: <1653271969.18771.1593605240536.JavaMail.zimbra@efficios.com>
References: <5efd3314-04ed-4868-a0c9-408434d330f4.zhenyu.ren@aliyun.com>
 <49dab706-ab7e-4156-9163-b8d9105b173d.zhenyu.ren@aliyun.com>
 <65af8a29-4fd7-454c-a060-8f06cb7bc931.zhenyu.ren@aliyun.com>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2207948523515276267=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 49xg2l4KSXz18bK
 for <lttng-dev@lists.lttng.org>; Wed,  1 Jul 2020 08:07:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 231722CD433
 for <lttng-dev@lists.lttng.org>; Wed,  1 Jul 2020 08:07:21 -0400 (EDT)
In-Reply-To: <65af8a29-4fd7-454c-a060-8f06cb7bc931.zhenyu.ren@aliyun.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============2207948523515276267==
Content-Type: multipart/alternative;
	boundary="=_9aee5e4e-09e3-4c71-b579-6a3595c149fb"

--=_9aee5e4e-09e3-4c71-b579-6a3595c149fb
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,=20

Make sure you use single quotes in your shell around wildcards, else the=20
shell will try to expand them to files in the current directory, e.g., you =
need to do:=20

lttng enable-event -u 'system_event*' -c channel0 -s misc_data=20

This could very well explain why sometimes your events don't get enabled: i=
f the=20
wildcard matches files in the current directory.=20

Thanks,=20

Mathieu=20

----- On Jun 30, 2020, at 11:56 PM, zhenyu.ren <zhenyu.ren@aliyun.com> wrot=
e:=20

> Ah, I have to say that I use the wildcard in tracepoint name when enable-=
event
> to the channel, i.e. ./lttng enable-event -u system_event* -c channel0 -s
> misc_data. Of course, there are the other tracepoints with wildcard succe=
ed in
> registring.

>> ------------------------------------------------------------------
>> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9Azhenyu.ren via lttng-dev <lttng-dev@=
lists.lttng.org>
>> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2020=E5=B9=B47=E6=9C=881=E6=
=97=A5(=E6=98=9F=E6=9C=9F=E4=B8=89) 11:44
>> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9Alttng-dev <lttng-dev@lists.lttng.org=
>; mathieu.desnoyers
>> <mathieu.desnoyers@efficios.com>
>> =E4=B8=BB =E9=A2=98=EF=BC=9A[lttng-dev] =E5=9B=9E=E5=A4=8D=EF=BC=9A some=
 tracepoints not exist in metadata?

>> I'd like to add that both "lttng list -u" and "lttng list $session_name"=
 can get
>> those tracepoints' names...
>> ------------------------------------------------------------------
>> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9Azhenyu.ren via lttng-dev <lttng-dev@=
lists.lttng.org>
>> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2020=E5=B9=B47=E6=9C=881=E6=
=97=A5(=E6=98=9F=E6=9C=9F=E4=B8=89) 11:05
>> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9Alttng-dev <lttng-dev@lists.lttng.org=
>; mathieu.desnoyers
>> <mathieu.desnoyers@efficios.com>
>> =E4=B8=BB =E9=A2=98=EF=BC=9A[lttng-dev] some tracepoints not exist in me=
tadata?

>> Hi,
>> I find sometimes there are some tracepoints not exist in metadata file(b=
ut they
>> are in the list of lttng list -u) and the end result is they can NOT be =
logged.
>> I can not always reproduce it. It bothered me for 2 days.
>> The lttng version is 2.7, I know it is not the latest version but there =
are some
>> reasons I can't update it. So, is this a known bug? If yes, It will be v=
ery
>> appreciated if you can give me any advice about the bug info(I can cherr=
y pick
>> the correspond fix). Otherwise, maybe I have to give up my favoriate Ltt=
ng....

>> Thank you in advance!
>> zhenyu.ren

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

--=_9aee5e4e-09e3-4c71-b579-6a3595c149fb
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>Hi,<br></div><div><br data-mce-bogus=3D"1">=
</div><div>Make sure you use single quotes in your shell around wildcards, =
else the<br data-mce-bogus=3D"1"></div><div>shell will try to expand them t=
o files in the current directory, e.g., you need to do:<br data-mce-bogus=
=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>lttng enable-event -u=
 'system_event*' -c channel0 -s misc_data<br data-mce-bogus=3D"1"></div><di=
v><br data-mce-bogus=3D"1"></div><div>This could very well explain why some=
times your events don't get enabled: if the<br data-mce-bogus=3D"1"></div><=
div>wildcard matches files in the current directory.<br data-mce-bogus=3D"1=
"></div><div><br data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=
=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Mathieu</div><div><br=
 data-mce-bogus=3D"1"></div><div><span id=3D"zwchr" data-marker=3D"__DIVIDE=
R__">----- On Jun 30, 2020, at 11:56 PM, zhenyu.ren &lt;zhenyu.ren@aliyun.c=
om&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockqu=
ote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px=
;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font-=
family:Helvetica,Arial,sans-serif;font-size:12pt;"><div class=3D"__aliyun_e=
mail_body_block"><div><span style=3D"font-family:'tahoma' , 'arial' , 'sthe=
iti' , 'simsun';font-size:14px;color:#000000">Ah, I have to say that I use =
the wildcard in tracepoint name when enable-event to the channel, i.e. ./lt=
tng enable-event -u&nbsp;system_event*&nbsp;-c&nbsp;channel0&nbsp;-s&nbsp;m=
isc_data. Of course, there are the other tracepoints with wildcard succeed =
in registring.</span></div><blockquote style=3D"margin-right:0;margin-top:0=
;margin-bottom:0"><div><span style=3D"font-family:'tahoma' , 'arial' , 'sth=
eiti' , 'simsun';font-size:14px;color:#000000">----------------------------=
--------------------------------------</span></div><div><span style=3D"font=
-family:'tahoma' , 'arial' , 'stheiti' , 'simsun';font-size:14px;color:#000=
000">=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9Azhenyu.ren via lttng-dev &lt;lttng=
-dev@lists.lttng.org&gt;</span></div><div><span style=3D"font-family:'tahom=
a' , 'arial' , 'stheiti' , 'simsun';font-size:14px;color:#000000">=E5=8F=91=
=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2020=E5=B9=B47=E6=9C=881=E6=97=A5(=E6=
=98=9F=E6=9C=9F=E4=B8=89) 11:44</span></div><div><span style=3D"font-family=
:'tahoma' , 'arial' , 'stheiti' , 'simsun';font-size:14px;color:#000000">=
=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9Alttng-dev &lt;lttng-dev@lists.lttng.org=
&gt;; mathieu.desnoyers &lt;mathieu.desnoyers@efficios.com&gt;</span></div>=
<div><span style=3D"font-family:'tahoma' , 'arial' , 'stheiti' , 'simsun';f=
ont-size:14px;color:#000000">=E4=B8=BB=E3=80=80=E9=A2=98=EF=BC=9A[lttng-dev=
] =E5=9B=9E=E5=A4=8D=EF=BC=9A some tracepoints not exist in metadata?</span=
></div><div><span style=3D"font-family:'tahoma' , 'arial' , 'stheiti' , 'si=
msun';font-size:14px;color:#000000"><br></span></div><div><font face=3D"Tah=
oma, Arial, STHeiti, SimSun" color=3D"#000000">I'd like to add that&nbsp;</=
font><span class=3D" __aliyun_node_has_color" style=3D"color:#000000;font-f=
amily:'tahoma' , 'arial' , 'stheiti' , 'simsun'">both "lttng list -u" and "=
lttng list $session_name" can get those tracepoints' names...&nbsp;</span><=
/div><div><span class=3D" __aliyun_node_has_color" style=3D"font-family:'ta=
homa' , 'arial' , 'stheiti' , 'simsun';font-size:14px;color:#000000">------=
------------------------------------------------------------</span></div><d=
iv><span class=3D" __aliyun_node_has_color" style=3D"font-family:'tahoma' ,=
 'arial' , 'stheiti' , 'simsun';font-size:14px;color:#000000">=E5=8F=91=E4=
=BB=B6=E4=BA=BA=EF=BC=9Azhenyu.ren via lttng-dev &lt;lttng-dev@lists.lttng.=
org&gt;</span></div><div><span class=3D" __aliyun_node_has_color" style=3D"=
font-family:'tahoma' , 'arial' , 'stheiti' , 'simsun';font-size:14px;color:=
#000000">=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2020=E5=B9=B47=E6=9C=
=881=E6=97=A5(=E6=98=9F=E6=9C=9F=E4=B8=89) 11:05</span></div><div><span cla=
ss=3D" __aliyun_node_has_color" style=3D"font-family:'tahoma' , 'arial' , '=
stheiti' , 'simsun';font-size:14px;color:#000000">=E6=94=B6=E4=BB=B6=E4=BA=
=BA=EF=BC=9Alttng-dev &lt;lttng-dev@lists.lttng.org&gt;; mathieu.desnoyers =
&lt;mathieu.desnoyers@efficios.com&gt;</span></div><div><span class=3D" __a=
liyun_node_has_color" style=3D"font-family:'tahoma' , 'arial' , 'stheiti' ,=
 'simsun';font-size:14px;color:#000000">=E4=B8=BB=E3=80=80=E9=A2=98=EF=BC=
=9A[lttng-dev] some tracepoints not exist in metadata?</span></div><div><sp=
an class=3D" __aliyun_node_has_color" style=3D"font-family:'tahoma' , 'aria=
l' , 'stheiti' , 'simsun';font-size:14px;color:#000000"><br></span></div><d=
iv><span class=3D" __aliyun_node_has_color __aliyun_node_has_color" style=
=3D"font-family:'tahoma' , 'arial' , 'stheiti' , 'simsun';font-size:14px;co=
lor:#000000">Hi,</span></div><div><span class=3D" __aliyun_node_has_color _=
_aliyun_node_has_color" style=3D"font-family:'tahoma' , 'arial' , 'stheiti'=
 , 'simsun';font-size:14px;color:#000000">&nbsp; &nbsp;I find sometimes the=
re are some tracepoints not exist in metadata file(but they are in the list=
 of lttng list -u) and the end result is&nbsp; they can NOT be logged. I ca=
n not always reproduce it. It bothered me for 2 days.&nbsp;</span></div><di=
v><span class=3D" __aliyun_node_has_color __aliyun_node_has_color" style=3D=
"font-family:'tahoma' , 'arial' , 'stheiti' , 'simsun';font-size:14px;color=
:#000000"></span>&nbsp; &nbsp;The lttng version is 2.7, I know it is not th=
e latest version but there are some reasons I can't update it. So, is this =
a known bug?&nbsp; If yes, It will be very appreciated if you can give me a=
ny advice about the bug info(I can cherry pick the correspond fix). Otherwi=
se, maybe I have to give up my favoriate Lttng....</div><br><div>Thank you =
in advance!</div><div>zhenyu.ren</div></blockquote></div><br></blockquote><=
/div><div><br></div><div data-marker=3D"__SIG_POST__">-- <br></div><div>Mat=
hieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</div></div></bod=
y></html>
--=_9aee5e4e-09e3-4c71-b579-6a3595c149fb--

--===============2207948523515276267==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2207948523515276267==--
