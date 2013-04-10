From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: GSoC 2013 proposal - Babeltrace python bindings
Date: Wed, 10 Apr 2013 17:28:16 -0400
Message-ID: <CA+jJMxthrZXAeUE-J3muXVWsAfPLyRbtYb8oQsodSQmP29sTKg__3902.46439860693$1365629335$gmane$org@mail.gmail.com>
References: <CAB44bLY4dUPe_fJj7v5oU6hnDAqypmoi3Mt=km5GHkDUOa6pPg@mail.gmail.com>
	<CA+jJMxsAE=5abYynLYvzCw9YqrtuDLn9-ToouQ8WoFzjpKsXRQ@mail.gmail.com>
	<CAB44bLYaRCCNnkJ0Vkd180dgv63748ZM=5TNErvzAZAUETSobA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2024447365=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1UQ2Z4-0008Jz-Tl
	for lttng-dev@lists.lttng.org; Wed, 10 Apr 2013 17:28:23 -0400
Received: by mail-wi0-f169.google.com with SMTP id c10so6658078wiw.2
	for <lttng-dev@lists.lttng.org>; Wed, 10 Apr 2013 14:28:16 -0700 (PDT)
In-Reply-To: <CAB44bLYaRCCNnkJ0Vkd180dgv63748ZM=5TNErvzAZAUETSobA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Xuan Hu <huxuan8218528@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============2024447365==
Content-Type: multipart/alternative; boundary=f46d0438914b1ef7a804da08595f

--f46d0438914b1ef7a804da08595f
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: quoted-printable

Hi Xuan,

There is no public API list that I know of. You'll want to have a look at
the public headers in the include/babeltrace folder. There is also an
official Babeltrace API documentation in doc/API.txt that provides a
high-level description of the interface and the terminology used.

J=A8=A6r=A8=A6mie



On Wed, Apr 10, 2013 at 1:23 AM, Xuan Hu <huxuan8218528@gmail.com> wrote:

> Hi, jgalar.
>
> Thx for your detailed clarification. I will begin with looking throuth th=
e
> CTF specification and investigation with the code of bing/python branch.
> I have one little question, where can I find the list of libbabeltrace's
> public API? And I also failed to find documents tends for developments an=
d
> contributors. I think these would be helpful for me to get fimiliar with
> our projects. :-)
>
> Wish for your reply.
>
>
> On Wed, Apr 10, 2013 at 3:37 AM, J=A8=A6r=A8=A6mie Galarneau <
> jeremie.galarneau@efficios.com> wrote:
>
>> Hi Xuan,
>>
>> First, thanks for reaching out!
>>
>> Basically, the Babeltrace Python bindings project aims at providing
>> Python developers with a library to read the trace formats supported by
>> Babeltrace. I'll take the chance to detail what we had in mind with this
>> project.
>>
>> The first part consists of producing Python bindings to libbabeltrace's
>> public API. This has already been done last summer but is not yet part o=
f
>> the master branch. It currently lives in the "bindings/python" branch of
>> Babeltrace's repository[1]. However, it is not completely up-to-date and
>> lacks thorough testing.
>>
>> The second part, which is more of an interface design exercise, is
>> exposing the trace data read by libbabeltrace in a "Pythonic" way. That
>> includes implementing Python's generator-iterator interface, expressing =
the
>> trace metadata using Python's data structures, etc. libbabeltrace can al=
so
>> be used as a trace writer so the Python interface should expose this
>> functionality by providing a symmetric output interface. All in all, it
>> calls for a lot more design work than actual implementation.
>>
>> For starters, you may want to have a look at the CTF specification[2],
>> which is currently the only trace format supported by Babeltrace, to giv=
e
>> you an idea of the challenges at hand. Trying out the complete LTTng
>> toolchain will also give you a better view of this project.
>>
>> [1]
>> https://bugs.lttng.org/projects/babeltrace/repository/show?rev=3Dbinding=
s%2Fpython
>> [2]
>> http://git.efficios.com/?p=3Dctf.git;a=3Dblob_plain;f=3Dcommon-trace-for=
mat-specification.txt;hb=3Dmaster
>>
>> Don't hesitate to come forward and propose a tentative API or ask for
>> clarifications.
>>
>> Regards,
>> J=A8=A6r=A8=A6mie
>>
>> On Tue, Apr 9, 2013 at 5:38 AM, Xuan Hu <huxuan8218528@gmail.com> wrote:
>>
>>> Hello everyone,
>>>
>>> I'm really interested in the project of `Babeltrace python bindings`.
>>> Besides I'm confident with my python skill and I'm willing to study mor=
e
>>> skills related. As far as I know, I think this is a somewhat standalone
>>> project which should create a module for python programmers to get the
>>> results which babeltrace produce. Wish potential mentor (jgalar) can ju=
dge
>>> whether it is or not. Besides I wonder to know any suggestions for me t=
o
>>> begin with this project?
>>>
>>> --
>>> =EC=E8=EC=D3 Sean.Hu
>>>
>>> =B1=B1=BE=A9=B4=F3=D1=A7=D0=C5=CF=A2=BF=C6=D1=A7=BC=BC=CA=F5=D1=A7=D4=
=BA2012=BC=B6=CB=B6=CA=BF=D1=D0=BE=BF=C9=FA
>>> 2012, Master Degree Candidate, EECS, PKU
>>>
>>> Blog <http://huxuan.org/> | GitHproposeub <https://github.com/huxuan/>|
>>> Twitter <https://twitter.com/huxuan/> | Douban<http://www.douban.com/pe=
ople/huxuan/>|
>>> Google+ <https://plus.google.com/u/0/116930918200210859389> | Jiepang<h=
ttp://jiepang.com/huxuan/> |
>>> Weibo <http://weibo.com/victorhu>
>>>
>>> _______________________________________________
>>> lttng-dev mailing list
>>> lttng-dev@lists.lttng.org
>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>
>>>
>>
>>
>> --
>> J=A8=A6r=A8=A6mie Galarneau
>> EfficiOS Inc.
>> http://www.efficios.com
>>
>
>
>
> --
> =EC=E8=EC=D3 Sean.Hu
>
> =B1=B1=BE=A9=B4=F3=D1=A7=D0=C5=CF=A2=BF=C6=D1=A7=BC=BC=CA=F5=D1=A7=D4=BA2=
012=BC=B6=CB=B6=CA=BF=D1=D0=BE=BF=C9=FA
> 2012, Master Degree Candidate, EECS, PKU
>
> Blog <http://huxuan.org/> | GitHub <https://github.com/huxuan/> | Twitter=
<https://twitter.com/huxuan/>|
> Douban <http://www.douban.com/people/huxuan/> | Google+<https://plus.goog=
le.com/u/0/116930918200210859389>|
> Jiepang <http://jiepang.com/huxuan/> | Weibo <http://weibo.com/victorhu>
>



--=20
J=A8=A6r=A8=A6mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--f46d0438914b1ef7a804da08595f
Content-Type: text/html; charset=GB2312
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Xuan,<div><br></div><div style>There is no public API l=
ist that I know of. You&#39;ll want to have a look at the public headers in=
 the include/babeltrace folder. There is also an official Babeltrace API do=
cumentation in doc/API.txt that provides a high-level description of the in=
terface and the terminology used.</div>
<div style><br></div><div style>J=A8=A6r=A8=A6mie</div><div style><br></div=
><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Wed, Apr =
10, 2013 at 1:23 AM, Xuan Hu <span dir=3D"ltr">&lt;<a href=3D"mailto:huxuan=
8218528@gmail.com" target=3D"_blank">huxuan8218528@gmail.com</a>&gt;</span>=
 wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr">Hi, jgalar.<div><br></div><=
div>Thx for your detailed clarification. I will begin with looking throuth =
the CTF specification and investigation with the code of bing/python branch=
.</div>
<div>I have one little question, where can I find the list of libbabeltrace=
&#39;s public API? And I also failed to find documents tends for developmen=
ts and contributors. I think these would be helpful for me to get fimiliar =
with our projects. :-)</div>

<div><br></div><div>Wish for your reply.</div></div><div class=3D"gmail_ext=
ra"><div><div class=3D"h5"><br><br><div class=3D"gmail_quote">On Wed, Apr 1=
0, 2013 at 3:37 AM, J=A8=A6r=A8=A6mie Galarneau <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:jeremie.galarneau@efficios.com" target=3D"_blank">jeremie.gala=
rneau@efficios.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr">Hi Xuan,<div><br></div><div=
>First, thanks for reaching out!</div><div><br></div><div>Basically, the Ba=
beltrace Python bindings project aims at providing Python developers with a=
 library to read the trace formats supported by Babeltrace. I&#39;ll take t=
he chance to detail what we had in mind with this project.</div>



<div><br></div><div>The first part consists of producing Python bindings to=
 libbabeltrace&#39;s public API. This has already been done last summer but=
 is not yet part of the master branch. It currently lives in the &quot;bind=
ings/python&quot; branch of Babeltrace&#39;s repository[1]. However, it is =
not completely up-to-date and lacks thorough testing.</div>



<div><br></div><div>The second part, which is more of an interface design e=
xercise, is exposing the trace data read by libbabeltrace in a &quot;Python=
ic&quot; way. That includes implementing Python&#39;s generator-iterator in=
terface, expressing the trace metadata using Python&#39;s data structures, =
etc. libbabeltrace can also be used as a trace writer so the Python interfa=
ce should expose this functionality by providing a symmetric output interfa=
ce. All in all, it calls for a lot more design work than actual implementat=
ion.</div>



<div><br></div><div>For starters, you may want to have a look at the CTF sp=
ecification[2], which is currently the only trace format supported by Babel=
trace, to give you an idea of the challenges at hand. Trying out the comple=
te LTTng toolchain will also give you a better view of this project.</div>



<div><br></div><div>[1]&nbsp;<a href=3D"https://bugs.lttng.org/projects/bab=
eltrace/repository/show?rev=3Dbindings%2Fpython" target=3D"_blank">https://=
bugs.lttng.org/projects/babeltrace/repository/show?rev=3Dbindings%2Fpython<=
/a><br></div>



<div class=3D"gmail_extra">[2]&nbsp;<a href=3D"http://git.efficios.com/?p=
=3Dctf.git;a=3Dblob_plain;f=3Dcommon-trace-format-specification.txt;hb=3Dma=
ster" target=3D"_blank">http://git.efficios.com/?p=3Dctf.git;a=3Dblob_plain=
;f=3Dcommon-trace-format-specification.txt;hb=3Dmaster</a><br>



<br>Don&#39;t hesitate to come forward and propose a tentative API or ask f=
or clarifications.<br><br>Regards,<br>J=A8=A6r=A8=A6mie<br><br><div class=
=3D"gmail_quote"><div><div>On Tue, Apr 9, 2013 at 5:38 AM, Xuan Hu <span di=
r=3D"ltr">&lt;<a href=3D"mailto:huxuan8218528@gmail.com" target=3D"_blank">=
huxuan8218528@gmail.com</a>&gt;</span> wrote:<br>



</div></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-s=
tyle:solid;padding-left:1ex"><div dir=3D"ltr"><div><div>Hello everyone,<div=
>

<br></div><div>I&#39;m really interested in the project of `Babeltrace pyth=
on bindings`. Besides I&#39;m confident with my python skill and I&#39;m wi=
lling to study more skills related. As far as I know, I think this is a som=
ewhat standalone project which should create a module for python programmer=
s to get the results which babeltrace produce. Wish potential mentor (jgala=
r) can judge whether it is or not. Besides I wonder to know any suggestions=
 for me to begin with this project?</div>



</div></div><span><font color=3D"#888888">
<div><div><div><br></div>-- <br><div dir=3D"ltr"><div>=EC=E8=EC=D3 Sean.Hu<=
/div><div><br></div><div><div><div><div><div>=B1=B1=BE=A9=B4=F3=D1=A7=D0=C5=
=CF=A2=BF=C6=D1=A7=BC=BC=CA=F5=D1=A7=D4=BA2012=BC=B6=CB=B6=CA=BF=D1=D0=BE=
=BF=C9=FA</div><div>2012, Master Degree Candidate, EECS, PKU</div><div><br>=
</div></div></div>
<div><a href=3D"http://huxuan.org/" target=3D"_blank">Blog</a>&nbsp;|&nbsp;=
<a href=3D"https://github.com/huxuan/" target=3D"_blank">GitHproposeub</a> =
| <a href=3D"https://twitter.com/huxuan/" target=3D"_blank">Twitter</a> |&n=
bsp;<a href=3D"http://www.douban.com/people/huxuan/" target=3D"_blank">Doub=
an</a> | <a href=3D"https://plus.google.com/u/0/116930918200210859389" targ=
et=3D"_blank">Google+</a> |&nbsp;<a href=3D"http://jiepang.com/huxuan/" tar=
get=3D"_blank">Jiepang</a>&nbsp;| <a href=3D"http://weibo.com/victorhu" tar=
get=3D"_blank">Weibo</a><br>




</div></div></div></div>
</div></div></font></span></div>
<br>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
<br></blockquote></div><span><font color=3D"#888888"><br><br clear=3D"all">=
<div><br></div>-- <br>J=A8=A6r=A8=A6mie Galarneau<br>EfficiOS Inc.<br><a hr=
ef=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.com</a=
>
</font></span></div></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br></div></div>=
<div dir=3D"ltr"><div>=EC=E8=EC=D3 Sean.Hu</div><div><br></div><div><div><d=
iv><div class=3D"h5"><div>=B1=B1=BE=A9=B4=F3=D1=A7=D0=C5=CF=A2=BF=C6=D1=A7=
=BC=BC=CA=F5=D1=A7=D4=BA2012=BC=B6=CB=B6=CA=BF=D1=D0=BE=BF=C9=FA</div><div>=
2012, Master Degree Candidate, EECS, PKU</div>
<div><br></div>
</div></div><div><a href=3D"http://huxuan.org/" target=3D"_blank">Blog</a>&=
nbsp;|&nbsp;<a href=3D"https://github.com/huxuan/" target=3D"_blank">GitHub=
</a> | <a href=3D"https://twitter.com/huxuan/" target=3D"_blank">Twitter</a=
> |&nbsp;<a href=3D"http://www.douban.com/people/huxuan/" target=3D"_blank"=
>Douban</a> | <a href=3D"https://plus.google.com/u/0/116930918200210859389"=
 target=3D"_blank">Google+</a> |&nbsp;<a href=3D"http://jiepang.com/huxuan/=
" target=3D"_blank">Jiepang</a>&nbsp;| <a href=3D"http://weibo.com/victorhu=
" target=3D"_blank">Weibo</a><br>

</div></div></div></div>
</div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>J=A8=A6r=A8=
=A6mie Galarneau<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" ta=
rget=3D"_blank">http://www.efficios.com</a>
</div></div>

--f46d0438914b1ef7a804da08595f--


--===============2024447365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2024447365==--
