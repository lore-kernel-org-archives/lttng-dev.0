From: "Burton, Ross" <ross.burton-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Bogus openembedded gcc patch
Date: Wed, 27 Jan 2016 11:31:08 +0000
Message-ID: <CAJTo0LZazTzkp94ASdACaBOuC4JpNWCpnf46kAucjY5B+wX2vQ@mail.gmail.com>
References: <1037243108.4336.1453770172960.JavaMail.zimbra@efficios.com>
	<51287CFC-6F3C-43B1-9190-84F3B20C192E@gmail.com>
	<433937130.5072.1453838389504.JavaMail.zimbra@efficios.com>
	<CAMKF1sofnyADcNkAc+YrXjPED=ALxf60oPEsuQiJTAY87oB31Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0310605646=="
Return-path: <openembedded-core-bounces-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org>
In-Reply-To: <CAMKF1sofnyADcNkAc+YrXjPED=ALxf60oPEsuQiJTAY87oB31Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/openembedded-core>,
	<mailto:openembedded-core-request-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/openembedded-core/>
List-Post: <mailto:openembedded-core-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org>
List-Help: <mailto:openembedded-core-request-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/openembedded-core>,
	<mailto:openembedded-core-request-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org?subject=subscribe>
Sender: openembedded-core-bounces-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org
Errors-To: openembedded-core-bounces-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org
To: Khem Raj <raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: lttng-dev <lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org>, Mathieu Desnoyers <mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org>, Patches and discussions about the oe-core layer <openembedded-core-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org>
List-Id: lttng-dev@lists.lttng.org

--===============0310605646==
Content-Type: multipart/alternative; boundary=089e0149cbe88a4904052a4f24bc

--089e0149cbe88a4904052a4f24bc
Content-Type: text/plain; charset=UTF-8

On 26 January 2016 at 23:14, Khem Raj <raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> > Yes, we have narrowed down our problem to this specific patch by
> > removing the patch from the OE gcc patches, rebuilding gcc, and
> > then building our test program with that gcc. The problem goes
> > away when we do so, which points directly to that patch as a
> > culprit.
> >
> > Test program is attached.
>
> Ok I think we can remove this from master and jethro release
>

Mathieu, as you found this do you want the glory by submitting a the
removal patch?

Cheerss,
Ross

--089e0149cbe88a4904052a4f24bc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On 26 January 2016 at 23:14, Khem Raj <span dir=3D"ltr">&lt;<a href=3D"mail=
to:raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> =
wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex"><div id=3D":aj" class=3D"a3s" styl=
e=3D"overflow:hidden">&gt; Yes, we have narrowed down our problem to this s=
pecific patch by<br>
&gt; removing the patch from the OE gcc patches, rebuilding gcc, and<br>
&gt; then building our test program with that gcc. The problem goes<br>
&gt; away when we do so, which points directly to that patch as a<br>
&gt; culprit.<br>
&gt;<br>
&gt; Test program is attached.<p></p>
<p dir=3D"ltr">Ok I think we can remove this from master and jethro release=
<br></p></div></blockquote></div><br>Mathieu, as you found this do you want=
 the glory by submitting a the removal patch?</div><div class=3D"gmail_extr=
a"><br></div><div class=3D"gmail_extra">Cheerss,</div><div class=3D"gmail_e=
xtra">Ross</div></div>

--089e0149cbe88a4904052a4f24bc--

--===============0310605646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
_______________________________________________
Openembedded-core mailing list
Openembedded-core-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org
http://lists.openembedded.org/mailman/listinfo/openembedded-core

--===============0310605646==--
