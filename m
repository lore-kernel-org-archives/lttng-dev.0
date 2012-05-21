From: Vanni Genua <vannigenua@gmail.com>
Subject: Re: BABELTRACE
Date: Mon, 21 May 2012 14:26:09 +0000
Message-ID: <CAO8ONPzPPpBFgt4Hz39OEu6HMkaoSiYrE=kmtdiBx3tokxTeMA__37111.8372925141$1338867443$gmane$org@mail.gmail.com>
References: <CAO8ONPzhd64AoBQFnuJ0agGHFzSQxNeFSQODmE7kWYk2jZQYHg@mail.gmail.com>
	<CAO8ONPzkLYMDD+Nee2dgzVbqCkyPLV1tmce2Z0M6_RgR7uY0ZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1291064712=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <vannigenua@gmail.com>) id 1SWTYt-0007x5-LN
	for lttng-dev@lists.lttng.org; Mon, 21 May 2012 10:26:16 -0400
Received: by wibhn14 with SMTP id hn14so1799957wib.5
	for <lttng-dev@lists.lttng.org>; Mon, 21 May 2012 07:26:10 -0700 (PDT)
In-Reply-To: <CAO8ONPzkLYMDD+Nee2dgzVbqCkyPLV1tmce2Z0M6_RgR7uY0ZA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Alexandre Montplaisir <alexandre.montplaisir@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

--===============1291064712==
Content-Type: multipart/alternative; boundary=0016e6de03b1f2a75104c08cae86

--0016e6de03b1f2a75104c08cae86
Content-Type: text/plain; charset=ISO-8859-1

I did
#./bootstrap
and it was ok
Then I did
#./configure
and I got this error:
checking for bison... bison -y
checking for flex... flex
checking lex output file root... lex.yy
checking lex library... -lfl
checking whether yytext is a pointer... yes
./configure: line 11626: syntax error near unexpected token `0.16'
./configure: line 11626: `  PKG_PROG_PKG_CONFIG(0.16)'

How to solve this bug?
Thanks
V.G.

On Mon, May 21, 2012 at 2:18 PM, Vanni Genua <vannigenua@gmail.com> wrote:

> Soved with Babeltrace Master.
> V.G.
>
>
> On Mon, May 21, 2012 at 1:55 PM, Vanni Genua <vannigenua@gmail.com> wrote:
>
>> Hi there,
>> so once I have correctly installed LTTng-modules, LTTng-ust and
>> LTTng-tools, I can use LTTng but not LTTng view. In order to use #lttng
>> view command I have to install Babeltrace, but it seems still to be a rc
>> version. As a matter of fact I downloaded it from
>> http://lttng.org/download and, according to README file, I launched
>> #./bootsrap but this file is not in the directory: it doesn't exist!
>> I'm stuck here now, any idea?
>> Vanni
>>
>
>

--0016e6de03b1f2a75104c08cae86
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I did <br>#./bootstrap <br>and it was ok<br>Then I did<br>#./configure<br>a=
nd I got this error:<br>checking for bison... bison -y<br>checking for flex=
... flex<br>checking lex output file root... lex.yy<br>checking lex library=
... -lfl<br>
checking whether yytext is a pointer... yes<br>./configure: line 11626: syn=
tax error near unexpected token `0.16&#39;<br>./configure: line 11626: `=A0=
 PKG_PROG_PKG_CONFIG(0.16)&#39;<br><br>How to solve this bug?<br>Thanks<br>
V.G.<br><br><div class=3D"gmail_quote">On Mon, May 21, 2012 at 2:18 PM, Van=
ni Genua <span dir=3D"ltr">&lt;<a href=3D"mailto:vannigenua@gmail.com" targ=
et=3D"_blank">vannigenua@gmail.com</a>&gt;</span> wrote:<br><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">
Soved with Babeltrace Master.<span class=3D"HOEnZb"><font color=3D"#888888"=
><br>V.G.</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br><br><div=
 class=3D"gmail_quote">On Mon, May 21, 2012 at 1:55 PM, Vanni Genua <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:vannigenua@gmail.com" target=3D"_blank">va=
nnigenua@gmail.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi there,<br>so once I have correctly instal=
led LTTng-modules, LTTng-ust and LTTng-tools, I can use LTTng but not LTTng=
 view. In order to use #lttng view command I have to install Babeltrace, bu=
t it seems still to be a rc version. As a matter of fact I downloaded it fr=
om <a href=3D"http://lttng.org/download" target=3D"_blank">http://lttng.org=
/download</a> and, according to README file, I launched #./bootsrap but thi=
s file is not in the directory: it doesn&#39;t exist!<br>


I&#39;m stuck here now, any idea?<span><font color=3D"#888888"><br>Vanni<br=
>
</font></span></blockquote></div><br>
</div></div></blockquote></div><br>

--0016e6de03b1f2a75104c08cae86--


--===============1291064712==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1291064712==--
