From: Junchang Wang <junchangwang@gmail.com>
Subject: Re: [RFC 0/4] userspace-rcu: Add lock-free,
 ordered singly linked list rculflist
Date: Thu, 11 Jul 2019 09:19:47 +0800
Message-ID: <CABoNC80dyFt3GYZ07Wi-USw=Sg7GzjpL0OF6+Rew6qhhvbYexw__40708.6924229347$1562808019$gmane$org@mail.gmail.com>
References: <1562729290-6437-1-git-send-email-junchangwang@gmail.com>
 <20190710151410.GB3812@joraj-alpa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6804362458809160301=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 by lists.lttng.org (Postfix) with ESMTPS id 45kdX007tDz16v8
 for <lttng-dev@lists.lttng.org>; Wed, 10 Jul 2019 21:19:59 -0400 (EDT)
Received: by mail-ot1-x344.google.com with SMTP id b7so4127952otl.11
 for <lttng-dev@lists.lttng.org>; Wed, 10 Jul 2019 18:19:59 -0700 (PDT)
In-Reply-To: <20190710151410.GB3812@joraj-alpa>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev@lists.lttng.org, Paul McKenney <paulmck@linux.ibm.com>
List-Id: lttng-dev@lists.lttng.org

--===============6804362458809160301==
Content-Type: multipart/alternative; boundary="0000000000009eeea1058d5d9778"

--0000000000009eeea1058d5d9778
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan,

Thanks for letting me know. The patch isn't in a hurry, so it's good for me
to discuss this patch after Mathieu returns.


Thanks,
--Junchang

On Wed, Jul 10, 2019 at 11:14 PM Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com> wrote:

> Hi Junchang,
>
> Thanks for contributing to URCU.
>
> I just wanted to let you know that Mathieu is currently on vacation for ~2
> weeks
> so do not expect much feedback until his return.
>
> Cheers
>
> On Wed, Jul 10, 2019 at 11:28:06AM +0800, Junchang Wang wrote:
> > Hi Mathieu and the list,
> >
> > I'm recently using userspace-rcu to build lock-free data structures.
> Thanks for
> > sharing this excellent project!
> >
> > In building a hash table, I am looking for an ordered singly linked list
> > that is lock-free. It seems such a list is missing in userspace-rcu. I
> > discussed this with Paul in the mailing list of perfbook, and he kindly
> > suggested me to submit my implementation to userspace-rcu. So here is the
> > RFC. Any comments and suggestions are warmly welcome.
> >
> > This singly linked list is based on the following research paper:
> >  - Maged M. Michael. High performance dynamic lock-free hash tables
> >    and list-based sets. In Proceedings of the fourteenth annual ACM
> >    symposium on Parallel algorithms and architectures, ACM Press,
> >    (2002), 73-82.
> >
> > And this implementation has the following unique features:
> >  (1) Insert, Delete, and Find operations are protected by RCU read_lock,
> >      such that the existence guarantees are provided by the RCU
> mechanism,
> >      and that no special memory management schemes (e.g., hazard
> pointers)
> >      is required anymore.
> >  (2) The use of the RCU mechanism can naturally prevent the ABA problem,
> >      such that no flag field is required in this implementation. Hence,
> >      we save a long integer (typically 8 bytes) for each node.
> >
> > This is my first patch to this mailing list, so please let me know if
> > I messed anything up. Any comments and suggestions are warmly welcome.
> >
> > Thanks,
> > --Junchang
> >
> > Junchang Wang (4):
> >   userspace-rcu: Add lock-free singly linked list rculflist
> >   userspace-rcu: Add sample code of rculflist
> >   userspace-rcu: Update Makefile.am to include rculflist into the
> >     project
> >   userspace-rcu: Add a brief description of rculflist in cds-api.md
> >
> >  doc/cds-api.md                                     |   7 +
> >  doc/examples/Makefile.am                           |  13 +-
> >  .../rculflist/Makefile.cds_lflist_delete_rcu       |  21 ++
> >  .../rculflist/Makefile.cds_lflist_find_rcu         |  21 ++
> >  .../rculflist/Makefile.cds_lflist_insert_rcu       |  21 ++
> >  doc/examples/rculflist/cds_lflist_delete_rcu.c     | 100 ++++++++
> >  doc/examples/rculflist/cds_lflist_find_rcu.c       |  96 +++++++
> >  doc/examples/rculflist/cds_lflist_insert_rcu.c     |  66 +++++
> >  include/Makefile.am                                |   1 +
> >  include/urcu/cds.h                                 |   1 +
> >  include/urcu/rculflist.h                           | 279
> +++++++++++++++++++++
> >  11 files changed, 625 insertions(+), 1 deletion(-)
> >  create mode 100644 doc/examples/rculflist/Makefile.cds_lflist_delete_rcu
> >  create mode 100644 doc/examples/rculflist/Makefile.cds_lflist_find_rcu
> >  create mode 100644 doc/examples/rculflist/Makefile.cds_lflist_insert_rcu
> >  create mode 100644 doc/examples/rculflist/cds_lflist_delete_rcu.c
> >  create mode 100644 doc/examples/rculflist/cds_lflist_find_rcu.c
> >  create mode 100644 doc/examples/rculflist/cds_lflist_insert_rcu.c
> >  create mode 100644 include/urcu/rculflist.h
> >
> > --
> > 2.7.4
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> --
> Jonathan Rajotte-Julien
> EfficiOS
>

--0000000000009eeea1058d5d9778
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Jonathan,</div><div><br></div><div>Thanks for lett=
ing me know. The patch isn&#39;t in a hurry, so it&#39;s good for me to dis=
cuss this patch after Mathieu returns.</div><div><br></div><div><br></div><=
div>Thanks,</div><div>--Junchang</div><br><div class=3D"gmail_quote"><div c=
lass=3D"gmail_attr" dir=3D"ltr">On Wed, Jul 10, 2019 at 11:14 PM Jonathan R=
ajotte-Julien &lt;<a href=3D"mailto:jonathan.rajotte-julien@efficios.com">j=
onathan.rajotte-julien@efficios.com</a>&gt; wrote:<br></div><blockquote sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex" class=3D"gmail_quote">Hi Junchang,<br>
<br>
Thanks for contributing to URCU.<br>
<br>
I just wanted to let you know that Mathieu is currently on vacation for ~2 =
weeks<br>
so do not expect much feedback until his return.<br>
<br>
Cheers<br>
<br>
On Wed, Jul 10, 2019 at 11:28:06AM +0800, Junchang Wang wrote:<br>
&gt; Hi Mathieu and the list,<br>
&gt; <br>
&gt; I&#39;m recently using userspace-rcu to build lock-free data structure=
s. Thanks for<br>
&gt; sharing this excellent project!<br>
&gt; <br>
&gt; In building a hash table, I am looking for an ordered singly linked li=
st<br>
&gt; that is lock-free. It seems such a list is missing in userspace-rcu. I=
<br>
&gt; discussed this with Paul in the mailing list of perfbook, and he kindl=
y<br>
&gt; suggested me to submit my implementation to userspace-rcu. So here is =
the<br>
&gt; RFC. Any comments and suggestions are warmly welcome.<br>
&gt; <br>
&gt; This singly linked list is based on the following research paper:<br>
&gt;=C2=A0 - Maged M. Michael. High performance dynamic lock-free hash tabl=
es<br>
&gt;=C2=A0 =C2=A0 and list-based sets. In Proceedings of the fourteenth ann=
ual ACM<br>
&gt;=C2=A0 =C2=A0 symposium on Parallel algorithms and architectures, ACM P=
ress,<br>
&gt;=C2=A0 =C2=A0 (2002), 73-82.<br>
&gt; <br>
&gt; And this implementation has the following unique features:<br>
&gt;=C2=A0 (1) Insert, Delete, and Find operations are protected by RCU rea=
d_lock,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 such that the existence guarantees are provided by=
 the RCU mechanism,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 and that no special memory management schemes (e.g=
., hazard pointers)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 is required anymore.<br>
&gt;=C2=A0 (2) The use of the RCU mechanism can naturally prevent the ABA p=
roblem,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 such that no flag field is required in this implem=
entation. Hence,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 we save a long integer (typically 8 bytes) for eac=
h node.<br>
&gt; <br>
&gt; This is my first patch to this mailing list, so please let me know if<=
br>
&gt; I messed anything up. Any comments and suggestions are warmly welcome.=
<br>
&gt; <br>
&gt; Thanks,<br>
&gt; --Junchang<br>
&gt; <br>
&gt; Junchang Wang (4):<br>
&gt;=C2=A0 =C2=A0userspace-rcu: Add lock-free singly linked list rculflist<=
br>
&gt;=C2=A0 =C2=A0userspace-rcu: Add sample code of rculflist<br>
&gt;=C2=A0 =C2=A0userspace-rcu: Update Makefile.am to include rculflist int=
o the<br>
&gt;=C2=A0 =C2=A0 =C2=A0project<br>
&gt;=C2=A0 =C2=A0userspace-rcu: Add a brief description of rculflist in cds=
-api.md<br>
&gt; <br>
&gt;=C2=A0 doc/cds-api.md=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A07 +<br>
&gt;=C2=A0 doc/examples/Makefile.am=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 13 +-<br=
>
&gt;=C2=A0 .../rculflist/Makefile.cds_lflist_delete_rcu=C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 21 ++<br>
&gt;=C2=A0 .../rculflist/Makefile.cds_lflist_find_rcu=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 21 ++<br>
&gt;=C2=A0 .../rculflist/Makefile.cds_lflist_insert_rcu=C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 21 ++<br>
&gt;=C2=A0 doc/examples/rculflist/cds_lflist_delete_rcu.c=C2=A0 =C2=A0 =C2=
=A0| 100 ++++++++<br>
&gt;=C2=A0 doc/examples/rculflist/cds_lflist_find_rcu.c=C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 96 +++++++<br>
&gt;=C2=A0 doc/examples/rculflist/cds_lflist_insert_rcu.c=C2=A0 =C2=A0 =C2=
=A0|=C2=A0 66 +++++<br>
&gt;=C2=A0 include/Makefile.am=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A01 +<br>
&gt;=C2=A0 include/urcu/cds.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 include/urcu/rculflist.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 279 ++++++++++=
+++++++++++<br>
&gt;=C2=A0 11 files changed, 625 insertions(+), 1 deletion(-)<br>
&gt;=C2=A0 create mode 100644 doc/examples/rculflist/Makefile.cds_lflist_de=
lete_rcu<br>
&gt;=C2=A0 create mode 100644 doc/examples/rculflist/Makefile.cds_lflist_fi=
nd_rcu<br>
&gt;=C2=A0 create mode 100644 doc/examples/rculflist/Makefile.cds_lflist_in=
sert_rcu<br>
&gt;=C2=A0 create mode 100644 doc/examples/rculflist/cds_lflist_delete_rcu.=
c<br>
&gt;=C2=A0 create mode 100644 doc/examples/rculflist/cds_lflist_find_rcu.c<=
br>
&gt;=C2=A0 create mode 100644 doc/examples/rculflist/cds_lflist_insert_rcu.=
c<br>
&gt;=C2=A0 create mode 100644 include/urcu/rculflist.h<br>
&gt; <br>
&gt; -- <br>
&gt; 2.7.4<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a target=3D"_blank" href=3D"mailto:lttng-dev@lists.lttng.org">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a target=3D"_blank" rel=3D"noreferrer" href=3D"https://lists.lttng.or=
g/cgi-bin/mailman/listinfo/lttng-dev">https://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev</a><br>
<br>
-- <br>
Jonathan Rajotte-Julien<br>
EfficiOS<br>
</blockquote></div></div>

--0000000000009eeea1058d5d9778--

--===============6804362458809160301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6804362458809160301==--
