From: Xuan Hu <huxuan8218528@gmail.com>
Subject: Re: GSoC 2013 proposal - Babeltrace python bindings
Date: Wed, 10 Apr 2013 13:23:35 +0800
Message-ID: <CAB44bLYaRCCNnkJ0Vkd180dgv63748ZM=5TNErvzAZAUETSobA__24693.9060664319$1365571448$gmane$org@mail.gmail.com>
References: <CAB44bLY4dUPe_fJj7v5oU6hnDAqypmoi3Mt=km5GHkDUOa6pPg@mail.gmail.com>
	<CA+jJMxsAE=5abYynLYvzCw9YqrtuDLn9-ToouQ8WoFzjpKsXRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0556164445=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-da0-f46.google.com ([209.85.210.46])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <huxuan8218528@gmail.com>) id 1UPnVU-0000C5-Vh
	for lttng-dev@lists.lttng.org; Wed, 10 Apr 2013 01:23:41 -0400
Received: by mail-da0-f46.google.com with SMTP id y19so50602dan.5
	for <lttng-dev@lists.lttng.org>; Tue, 09 Apr 2013 22:23:35 -0700 (PDT)
In-Reply-To: <CA+jJMxsAE=5abYynLYvzCw9YqrtuDLn9-ToouQ8WoFzjpKsXRQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0556164445==
Content-Type: multipart/alternative; boundary=e89a8fb208901d5cdc04d9fadf7f

--e89a8fb208901d5cdc04d9fadf7f
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi, jgalar.

Thx for your detailed clarification. I will begin with looking throuth the
CTF specification and investigation with the code of bing/python branch.
I have one little question, where can I find the list of libbabeltrace's
public API? And I also failed to find documents tends for developments and
contributors. I think these would be helpful for me to get fimiliar with
our projects. :-)

Wish for your reply.


On Wed, Apr 10, 2013 at 3:37 AM, J=C3=A9r=C3=A9mie Galarneau <
jeremie.galarneau@efficios.com> wrote:

> Hi Xuan,
>
> First, thanks for reaching out!
>
> Basically, the Babeltrace Python bindings project aims at providing Pytho=
n
> developers with a library to read the trace formats supported by
> Babeltrace. I'll take the chance to detail what we had in mind with this
> project.
>
> The first part consists of producing Python bindings to libbabeltrace's
> public API. This has already been done last summer but is not yet part of
> the master branch. It currently lives in the "bindings/python" branch of
> Babeltrace's repository[1]. However, it is not completely up-to-date and
> lacks thorough testing.
>
> The second part, which is more of an interface design exercise, is
> exposing the trace data read by libbabeltrace in a "Pythonic" way. That
> includes implementing Python's generator-iterator interface, expressing t=
he
> trace metadata using Python's data structures, etc. libbabeltrace can als=
o
> be used as a trace writer so the Python interface should expose this
> functionality by providing a symmetric output interface. All in all, it
> calls for a lot more design work than actual implementation.
>
> For starters, you may want to have a look at the CTF specification[2],
> which is currently the only trace format supported by Babeltrace, to give
> you an idea of the challenges at hand. Trying out the complete LTTng
> toolchain will also give you a better view of this project.
>
> [1]
> https://bugs.lttng.org/projects/babeltrace/repository/show?rev=3Dbindings=
%2Fpython
> [2]
> http://git.efficios.com/?p=3Dctf.git;a=3Dblob_plain;f=3Dcommon-trace-form=
at-specification.txt;hb=3Dmaster
>
> Don't hesitate to come forward and propose a tentative API or ask for
> clarifications.
>
> Regards,
> J=C3=A9r=C3=A9mie
>
> On Tue, Apr 9, 2013 at 5:38 AM, Xuan Hu <huxuan8218528@gmail.com> wrote:
>
>> Hello everyone,
>>
>> I'm really interested in the project of `Babeltrace python bindings`.
>> Besides I'm confident with my python skill and I'm willing to study more
>> skills related. As far as I know, I think this is a somewhat standalone
>> project which should create a module for python programmers to get the
>> results which babeltrace produce. Wish potential mentor (jgalar) can jud=
ge
>> whether it is or not. Besides I wonder to know any suggestions for me to
>> begin with this project?
>>
>> --
>> =E6=89=88=E7=85=8A Sean.Hu
>>
>> =E5=8C=97=E4=BA=AC=E5=A4=A7=E5=AD=A6=E4=BF=A1=E6=81=AF=E7=A7=91=E5=AD=A6=
=E6=8A=80=E6=9C=AF=E5=AD=A6=E9=99=A22012=E7=BA=A7=E7=A1=95=E5=A3=AB=E7=A0=
=94=E7=A9=B6=E7=94=9F
>> 2012, Master Degree Candidate, EECS, PKU
>>
>> Blog <http://huxuan.org/> | GitHproposeub <https://github.com/huxuan/> |
>> Twitter <https://twitter.com/huxuan/> | Douban<http://www.douban.com/peo=
ple/huxuan/>|
>> Google+ <https://plus.google.com/u/0/116930918200210859389> | Jiepang<ht=
tp://jiepang.com/huxuan/> |
>> Weibo <http://weibo.com/victorhu>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>
>
> --
> J=C3=A9r=C3=A9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
>



--=20
=E6=89=88=E7=85=8A Sean.Hu

=E5=8C=97=E4=BA=AC=E5=A4=A7=E5=AD=A6=E4=BF=A1=E6=81=AF=E7=A7=91=E5=AD=A6=E6=
=8A=80=E6=9C=AF=E5=AD=A6=E9=99=A22012=E7=BA=A7=E7=A1=95=E5=A3=AB=E7=A0=94=
=E7=A9=B6=E7=94=9F
2012, Master Degree Candidate, EECS, PKU

Blog <http://huxuan.org/> | GitHub <https://github.com/huxuan/> |
Twitter<https://twitter.com/huxuan/>|
Douban <http://www.douban.com/people/huxuan/> |
Google+<https://plus.google.com/u/0/116930918200210859389>|
Jiepang <http://jiepang.com/huxuan/> | Weibo <http://weibo.com/victorhu>

--e89a8fb208901d5cdc04d9fadf7f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi, jgalar.<div><br></div><div style>Thx for your detailed=
 clarification. I will begin with looking throuth the CTF specification and=
 investigation with the code of bing/python branch.</div><div style>I have =
one little question, where can I find the list of libbabeltrace&#39;s publi=
c API? And I also failed to find documents tends for developments and contr=
ibutors. I think these would be helpful for me to get fimiliar with our pro=
jects. :-)</div>
<div style><br></div><div style>Wish for your reply.</div></div><div class=
=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Wed, Apr 10, 2013 at=
 3:37 AM, J=C3=A9r=C3=A9mie Galarneau <span dir=3D"ltr">&lt;<a href=3D"mail=
to:jeremie.galarneau@efficios.com" target=3D"_blank">jeremie.galarneau@effi=
cios.com</a>&gt;</span> wrote:<br>
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


<div><br></div><div>[1]=C2=A0<a href=3D"https://bugs.lttng.org/projects/bab=
eltrace/repository/show?rev=3Dbindings%2Fpython" target=3D"_blank">https://=
bugs.lttng.org/projects/babeltrace/repository/show?rev=3Dbindings%2Fpython<=
/a><br></div>


<div class=3D"gmail_extra">[2]=C2=A0<a href=3D"http://git.efficios.com/?p=
=3Dctf.git;a=3Dblob_plain;f=3Dcommon-trace-format-specification.txt;hb=3Dma=
ster" target=3D"_blank">http://git.efficios.com/?p=3Dctf.git;a=3Dblob_plain=
;f=3Dcommon-trace-format-specification.txt;hb=3Dmaster</a><br>


<br>Don&#39;t hesitate to come forward and propose a tentative API or ask f=
or clarifications.<br><br>Regards,<br>J=C3=A9r=C3=A9mie<br><br><div class=
=3D"gmail_quote"><div><div class=3D"h5">On Tue, Apr 9, 2013 at 5:38 AM, Xua=
n Hu <span dir=3D"ltr">&lt;<a href=3D"mailto:huxuan8218528@gmail.com" targe=
t=3D"_blank">huxuan8218528@gmail.com</a>&gt;</span> wrote:<br>


</div></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-s=
tyle:solid;padding-left:1ex"><div dir=3D"ltr"><div><div class=3D"h5">Hello =
everyone,<div>
<br></div><div>I&#39;m really interested in the project of `Babeltrace pyth=
on bindings`. Besides I&#39;m confident with my python skill and I&#39;m wi=
lling to study more skills related. As far as I know, I think this is a som=
ewhat standalone project which should create a module for python programmer=
s to get the results which babeltrace produce. Wish potential mentor (jgala=
r) can judge whether it is or not. Besides I wonder to know any suggestions=
 for me to begin with this project?</div>


</div></div><span><font color=3D"#888888">
<div><div><div><br></div>-- <br><div dir=3D"ltr"><div>=E6=89=88=E7=85=8A Se=
an.Hu</div><div><br></div><div><div><div><div class=3D"h5"><div>=E5=8C=97=
=E4=BA=AC=E5=A4=A7=E5=AD=A6=E4=BF=A1=E6=81=AF=E7=A7=91=E5=AD=A6=E6=8A=80=E6=
=9C=AF=E5=AD=A6=E9=99=A22012=E7=BA=A7=E7=A1=95=E5=A3=AB=E7=A0=94=E7=A9=B6=
=E7=94=9F</div><div>2012, Master Degree Candidate, EECS, PKU</div><div><br>=
</div></div></div>
<div><a href=3D"http://huxuan.org/" target=3D"_blank">Blog</a>=C2=A0|=C2=A0=
<a href=3D"https://github.com/huxuan/" target=3D"_blank">GitHproposeub</a> =
| <a href=3D"https://twitter.com/huxuan/" target=3D"_blank">Twitter</a> |=
=C2=A0<a href=3D"http://www.douban.com/people/huxuan/" target=3D"_blank">Do=
uban</a> | <a href=3D"https://plus.google.com/u/0/116930918200210859389" ta=
rget=3D"_blank">Google+</a> |=C2=A0<a href=3D"http://jiepang.com/huxuan/" t=
arget=3D"_blank">Jiepang</a>=C2=A0| <a href=3D"http://weibo.com/victorhu" t=
arget=3D"_blank">Weibo</a><br>



</div></div></div></div>
</div></div></font></span></div>
<br>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
<br></blockquote></div><span class=3D"HOEnZb"><font color=3D"#888888"><br><=
br clear=3D"all"><div><br></div>-- <br>J=C3=A9r=C3=A9mie Galarneau<br>Effic=
iOS Inc.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://ww=
w.efficios.com</a>
</font></span></div></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div dir=3D"=
ltr"><div>=E6=89=88=E7=85=8A Sean.Hu</div><div><br></div><div><div><div>=E5=
=8C=97=E4=BA=AC=E5=A4=A7=E5=AD=A6=E4=BF=A1=E6=81=AF=E7=A7=91=E5=AD=A6=E6=8A=
=80=E6=9C=AF=E5=AD=A6=E9=99=A22012=E7=BA=A7=E7=A1=95=E5=A3=AB=E7=A0=94=E7=
=A9=B6=E7=94=9F</div><div>2012, Master Degree Candidate, EECS, PKU</div><di=
v><br></div>
<div><a href=3D"http://huxuan.org/" target=3D"_blank">Blog</a>=C2=A0|=C2=A0=
<a href=3D"https://github.com/huxuan/" target=3D"_blank">GitHub</a> | <a hr=
ef=3D"https://twitter.com/huxuan/" target=3D"_blank">Twitter</a> |=C2=A0<a =
href=3D"http://www.douban.com/people/huxuan/" target=3D"_blank">Douban</a> =
| <a href=3D"https://plus.google.com/u/0/116930918200210859389" target=3D"_=
blank">Google+</a> |=C2=A0<a href=3D"http://jiepang.com/huxuan/" target=3D"=
_blank">Jiepang</a>=C2=A0| <a href=3D"http://weibo.com/victorhu" target=3D"=
_blank">Weibo</a><br>
</div></div></div></div>
</div>

--e89a8fb208901d5cdc04d9fadf7f--


--===============0556164445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0556164445==--
