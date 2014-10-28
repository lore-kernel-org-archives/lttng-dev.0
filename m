From: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Subject: Re: [PATCH] lttng-tools: remove bogus argument from
	prove invocation
Date: Mon, 27 Oct 2014 22:38:46 -0400
Message-ID: <CAF4oYfEgNmiThfUW9Kj8+pYu-3QdE4KtUivr9mztf-Jb-=rocQ__9449.9152656228$1414463968$gmane$org@mail.gmail.com>
References: <1414461606-24103-1-git-send-email-nathan_lynch@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0792628298=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f174.google.com ([209.85.160.174])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.r.julien@gmail.com>) id 1XiwgO-0001qF-JL
 for lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 22:38:56 -0400
Received: by mail-yk0-f174.google.com with SMTP id q200so915139ykb.19
 for <lttng-dev@lists.lttng.org>; Mon, 27 Oct 2014 19:38:46 -0700 (PDT)
In-Reply-To: <1414461606-24103-1-git-send-email-nathan_lynch@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Nathan Lynch <nathan_lynch@mentor.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0792628298==
Content-Type: multipart/alternative; boundary=001a11331ff8e56ed50506728b3b

--001a11331ff8e56ed50506728b3b
Content-Type: text/plain; charset=UTF-8

Hey

On Mon, Oct 27, 2014 at 10:00 PM, Nathan Lynch <nathan_lynch@mentor.com>
wrote:

> An argument of "$2" was added to the prove command line in
> tests/run.sh by 68270f0f604e "Mi test: Basic test structure".  This is
> harmless since run.sh is never called with more than one argument, but
>

The multiple arguments could be overcome by adding "" to the multiple test
files list but as you said it is confusing and error prone.

This actually can be used to debug test with a "-v". Or add any basic
arguments to the prove command and was simply convenient at the time.If
this actually break patch from OE ( I assume OE stand for OpenEmbedded and
you are talking about this commit [1])  I'm okai with reverting the change
I introduced.

Thanks
Cheers!

[1]
https://github.com/openembedded/oe-core/commit/d0d184045e8034ddbc77549e681f187e12ab1d08


> it is confusing, and it breaks patches in OE that add support for

running tests on the target.
>
> Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
> ---
>  tests/run.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/run.sh b/tests/run.sh
> index ce51639f7626..c6c50fd9cff9 100755
> --- a/tests/run.sh
> +++ b/tests/run.sh
> @@ -19,4 +19,4 @@
>
>  [ -z "$1" ] && echo "Error: No testlist. Please specify a testlist to
> run." && exit 1
>
> -prove $2 --merge --exec '' - < $1
> +prove --merge --exec '' - < $1
> --
> 1.9.3
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



-- 
Jonathan Rajotte Julien

--001a11331ff8e56ed50506728b3b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hey<br><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote">On Mon, Oct 27, 2014 at 10:00 PM, Nathan Lynch <span dir=3D"ltr">&lt=
;<a href=3D"mailto:nathan_lynch@mentor.com" target=3D"_blank">nathan_lynch@=
mentor.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(20=
4,204,204);border-left-style:solid;padding-left:1ex">An argument of &quot;$=
2&quot; was added to the prove command line in<br>
tests/run.sh by 68270f0f604e &quot;Mi test: Basic test structure&quot;.=C2=
=A0 This is<br>
harmless since run.sh is never called with more than one argument, but<br><=
/blockquote><div><br></div><div>The multiple arguments could be overcome by=
 adding &quot;&quot; to the multiple test files list but as you said it is =
confusing and error prone. =C2=A0</div><div><br></div><div>This actually ca=
n be used to debug test with a &quot;-v&quot;. Or add any basic arguments t=
o the prove command and was simply convenient at the time.If this actually =
break patch from OE ( I assume OE stand for OpenEmbedded and you are talkin=
g about this commit [1]) =C2=A0I&#39;m okai with reverting the change I int=
roduced.</div><div><br></div><div>Thanks</div><div>Cheers!</div><div><br></=
div><div>[1]=C2=A0<a href=3D"https://github.com/openembedded/oe-core/commit=
/d0d184045e8034ddbc77549e681f187e12ab1d08">https://github.com/openembedded/=
oe-core/commit/d0d184045e8034ddbc77549e681f187e12ab1d08</a></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-styl=
e:solid;padding-left:1ex">
it is confusing, and it breaks patches in OE that add support for=C2=A0</bl=
ockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-styl=
e:solid;padding-left:1ex">
running tests on the target.<br>
<br>
Signed-off-by: Nathan Lynch &lt;<a href=3D"mailto:nathan_lynch@mentor.com">=
nathan_lynch@mentor.com</a>&gt;<br>
---<br>
=C2=A0tests/run.sh | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/tests/run.sh b/tests/run.sh<br>
index ce51639f7626..c6c50fd9cff9 100755<br>
--- a/tests/run.sh<br>
+++ b/tests/run.sh<br>
@@ -19,4 +19,4 @@<br>
<br>
=C2=A0[ -z &quot;$1&quot; ] &amp;&amp; echo &quot;Error: No testlist. Pleas=
e specify a testlist to run.&quot; &amp;&amp; exit 1<br>
<br>
-prove $2 --merge --exec &#39;&#39; - &lt; $1<br>
+prove --merge --exec &#39;&#39; - &lt; $1<br>
<span class=3D""><font color=3D"#888888">--<br>
1.9.3<br>
<br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div dir=3D"ltr">Jonathan Rajotte Julien</div>
</div></div>

--001a11331ff8e56ed50506728b3b--


--===============0792628298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0792628298==--
