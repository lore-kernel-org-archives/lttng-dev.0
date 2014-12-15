From: craig harmer <charmster@gmail.com>
Subject: Re: bug #857 -- babeltrace may core dump if index file
 is too short (with patch)
Date: Sun, 14 Dec 2014 22:09:07 -0800
Message-ID: <CADjtVtYg_aJ38eC82d6hT58450OuSsOubOZx6TOE3OJxkKKRyQ__17170.1124673293$1418646163$gmane$org@mail.gmail.com>
References: <CADjtVtb6J6ird2fYgWibLzq4tFmjNtv8G23Z+Krk6Fqabcc5Pw@mail.gmail.com>
 <CA+jJMxu1vGN_CoqdK6he8nfE-0P3nyFh9_9oFAs_bpjpP8tmJA@mail.gmail.com>
 <CAB4xu_3m73Dq2emRLdYz_=nvj4N3Ls6SshACb=2-1aTOA5Kwug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2143616611=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <charmster@gmail.com>) id 1Y0OqG-0002y5-PE
 for lttng-dev@lists.lttng.org; Mon, 15 Dec 2014 01:09:16 -0500
Received: by mail-ie0-f181.google.com with SMTP id tp5so9871006ieb.26
 for <lttng-dev@lists.lttng.org>; Sun, 14 Dec 2014 22:09:07 -0800 (PST)
In-Reply-To: <CAB4xu_3m73Dq2emRLdYz_=nvj4N3Ls6SshACb=2-1aTOA5Kwug@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Philippe Proulx <eeppeliteloop@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "charmer-lttng.org" <charmer-lttng.org@punchdown.org>
List-Id: lttng-dev@lists.lttng.org

--===============2143616611==
Content-Type: multipart/alternative; boundary=089e011602a885060f050a3b14a8

--089e011602a885060f050a3b14a8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Philippe, J=C3=A9r=C3=A9mie,

thanks.  now that i've read the contributor's guide i'll pull the patch
together into the proper format and email it to the list.

cheers,

craig.


On Sun, Dec 14, 2014 at 11:46 AM, Philippe Proulx <eeppeliteloop@gmail.com>
wrote:
>
> On Sun, Dec 14, 2014 at 1:47 PM, J=C3=A9r=C3=A9mie Galarneau
> <jeremie.galarneau@efficios.com> wrote:
> >
> > On Sat, Dec 13, 2014 at 10:08 PM, craig harmer <charmster@gmail.com>
> wrote:
> > > hi all,
> > >
> > > i opened a bug at bugs.lttng.org about a problem that i had where
> babeltrace
> > > would exit, possibly with a core dump, if one the trace's index files
> was
> > > too short.
> > >
> > > you can read the bug, with patch, at Bug #857 babeltrace will exit
> (often
> > > with a core dump) if an index file is too short
> > >
> > > i submitted a patch for the problem also fixes a few other places tha=
t
> short
> > > reads are not handled properly.
> > >
> > > there hasn't been any activity on the bug since i submitted the patch
> about
> > > 1 month ago, so i'm wondering if i need to submit the patch to this
> list as
> > > well.
> > >
> >
> > Hi Craig!
> >
> > I do recommend people send the patches to the mailing list and link to
> > it in the bug tracker. This makes it easier to track whether or not a
> > patch has been merged.
>
> Also, see this: <http://lttng.org/community/#contributors-guide>.
>
> Phil
> >
> > The bug tracker seems down at the moment (internal server error). I'll
> > look at the path once it is back up.
> >
> > Thanks,
> > J=C3=A9r=C3=A9mie
> >
> > > cheers,
> > >
> > > craig.
> > >
> > > _______________________________________________
> > > lttng-dev mailing list
> > > lttng-dev@lists.lttng.org
> > > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > >
> >
> >
> >
> > --
> > J=C3=A9r=C3=A9mie Galarneau
> > EfficiOS Inc.
> > http://www.efficios.com
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--089e011602a885060f050a3b14a8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:trebuche=
t ms,sans-serif">Philippe,<font> J=C3=A9r=C3=A9mie,<br><br></font></div><di=
v class=3D"gmail_default" style=3D"font-family:trebuchet ms,sans-serif"><fo=
nt>thanks.=C2=A0 now that i&#39;ve read the contributor&#39;s guide i&#39;l=
l pull the patch together into the proper format and email it to the list.<=
br><br>cheers,<br><br>craig.<br><br></font></div><div class=3D"gmail_defaul=
t" style=3D"font-family:trebuchet ms,sans-serif"><span name=3D"J=C3=A9r=C3=
=A9mie Galarneau" class=3D""> </span></div></div><div class=3D"gmail_extra"=
><br><div class=3D"gmail_quote">On Sun, Dec 14, 2014 at 11:46 AM, Philippe =
Proulx <span dir=3D"ltr">&lt;<a href=3D"mailto:eeppeliteloop@gmail.com" tar=
get=3D"_blank">eeppeliteloop@gmail.com</a>&gt;</span> wrote:<blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex"><span class=3D"">On Sun, Dec 14, 2014 at 1:47 PM, J=C3=A9r=
=C3=A9mie Galarneau<br>
&lt;<a href=3D"mailto:jeremie.galarneau@efficios.com">jeremie.galarneau@eff=
icios.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Sat, Dec 13, 2014 at 10:08 PM, craig harmer &lt;<a href=3D"mailto:c=
harmster@gmail.com">charmster@gmail.com</a>&gt; wrote:<br>
&gt; &gt; hi all,<br>
&gt; &gt;<br>
&gt; &gt; i opened a bug at <a href=3D"http://bugs.lttng.org" target=3D"_bl=
ank">bugs.lttng.org</a> about a problem that i had where babeltrace<br>
&gt; &gt; would exit, possibly with a core dump, if one the trace&#39;s ind=
ex files was<br>
&gt; &gt; too short.<br>
&gt; &gt;<br>
&gt; &gt; you can read the bug, with patch, at Bug #857 babeltrace will exi=
t (often<br>
&gt; &gt; with a core dump) if an index file is too short<br>
&gt; &gt;<br>
&gt; &gt; i submitted a patch for the problem also fixes a few other places=
 that short<br>
&gt; &gt; reads are not handled properly.<br>
&gt; &gt;<br>
&gt; &gt; there hasn&#39;t been any activity on the bug since i submitted t=
he patch about<br>
&gt; &gt; 1 month ago, so i&#39;m wondering if i need to submit the patch t=
o this list as<br>
&gt; &gt; well.<br>
&gt; &gt;<br>
&gt;<br>
&gt; Hi Craig!<br>
&gt;<br>
&gt; I do recommend people send the patches to the mailing list and link to=
<br>
&gt; it in the bug tracker. This makes it easier to track whether or not a<=
br>
&gt; patch has been merged.<br>
<br>
</span>Also, see this: &lt;<a href=3D"http://lttng.org/community/#contribut=
ors-guide" target=3D"_blank">http://lttng.org/community/#contributors-guide=
</a>&gt;.<br>
<br>
Phil<br>
<div class=3D"HOEnZb"><div class=3D"h5">&gt;<br>
&gt; The bug tracker seems down at the moment (internal server error). I&#3=
9;ll<br>
&gt; look at the path once it is back up.<br>
&gt;<br>
&gt; Thanks,<br>
&gt; J=C3=A9r=C3=A9mie<br>
&gt;<br>
&gt; &gt; cheers,<br>
&gt; &gt;<br>
&gt; &gt; craig.<br>
&gt; &gt;<br>
&gt; &gt; _______________________________________________<br>
&gt; &gt; lttng-dev mailing list<br>
&gt; &gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttn=
g.org</a><br>
&gt; &gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-=
dev" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttn=
g-dev</a><br>
&gt; &gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; J=C3=A9r=C3=A9mie Galarneau<br>
&gt; EfficiOS Inc.<br>
&gt; <a href=3D"http://www.efficios.com" target=3D"_blank">http://www.effic=
ios.com</a><br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=
</a><br>
</div></div></blockquote></div></div>

--089e011602a885060f050a3b14a8--


--===============2143616611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2143616611==--
