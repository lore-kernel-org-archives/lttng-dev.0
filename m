From: Junchang Wang <junchangwang@gmail.com>
Subject: Re: [PATCH v2 0/4] userspace-rcu: Add lock-free,
 ordered singly linked list
Date: Thu, 1 Aug 2019 18:51:36 +0800
Message-ID: <CABoNC827Knh0xTu9=h5-M4n=Xayz72E=nk0AkeVUSNf5vONg0g__2378.1495097623$1564656725$gmane$org@mail.gmail.com>
References: <1564407331-25820-1-git-send-email-junchangwang@gmail.com>
 <1759632476.1182.1564408558415.JavaMail.zimbra@efficios.com>
 <CABoNC821qnePU4Enrs8mSseVq-_Hp3Cehh93DO0+s=cKtDTZXQ@mail.gmail.com>
 <2090901729.4706.1564499733170.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2208686943243493489=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 by lists.lttng.org (Postfix) with ESMTPS id 45znD45GMWz1Gnp
 for <lttng-dev@lists.lttng.org>; Thu,  1 Aug 2019 06:51:48 -0400 (EDT)
Received: by mail-oi1-x244.google.com with SMTP id w79so53594866oif.10
 for <lttng-dev@lists.lttng.org>; Thu, 01 Aug 2019 03:51:48 -0700 (PDT)
In-Reply-To: <2090901729.4706.1564499733170.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, paulmck <paulmck@linux.ibm.com>
List-Id: lttng-dev@lists.lttng.org

--===============2208686943243493489==
Content-Type: multipart/alternative; boundary="000000000000408328058f0c0775"

--000000000000408328058f0c0775
Content-Type: text/plain; charset="UTF-8"

Hi Mathieu,

Thanks a lot for the feedback. Please see below,

On Tue, Jul 30, 2019 at 11:15 PM Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Jul 30, 2019, at 9:34 AM, Junchang Wang junchangwang@gmail.com
wrote:
>
> > On Mon, Jul 29, 2019 at 9:55 PM Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> >>
> >> ----- On Jul 29, 2019, at 9:35 AM, Junchang Wang junchangwang@gmail.com
wrote:
> >>
> >> > Hi Mathieu and the list,
> >> >
> >> > I'm recently using userspace-rcu to build lock-free data structures.
Thanks for
> >> > sharing this excellent project!
> >> >
> >> > In building a hash table, I am looking for an ordered singly linked
list
> >> > that is lock-free. It seems such a list is missing in userspace-rcu.
I
> >> > discussed this with Paul in the mailing list of perfbook, and he
kindly
> >> > suggested me to submit my implementation to userspace-rcu. So here
is the
> >> > RFC. Any comments and suggestions are warmly welcome.
> >>
> >> One point worth mentioning: the rculfhash data structure (rcu
lock-free hash
> >> table) already implements such list internally. You might want to have
a look
> >> at it, and perhaps just lift out its implementation into a separate .c
file
> >> and header file so we can expose its implementation publicly ?
> >>
> >> Items are linked through the struct cds_lfht_node next field.
> >>
> >> The struct cds_lfht_iter is used as a iterator on the list.
> >>
> >> struct cds_lfht tbl_oder, tbl_chunk and tbl_mmap contain the
> >> linked lists heads for each memory allocation scheme.
> >
> > Hi Mathieu,
> >
> > Thanks for the note. I checked rculfhash today, and the list
> > implementation within rculfhash is indeed quite similar to the one I'm
> > working on. I will check to see if we can merge the two versions and
> > provide an independent rculflist.
>
> Great!
>
> >
> >>
> >> I'm wondering why you need to re-implement a hash table though. What is
> >> missing from rculfhash to suit your needs ?
> >>
> >
> > The major reason is that I want a hash table that can change its hash
> > function on-the-fly. Split-ordered list is not adequate because it can
> > only increase/decrease the number of buckets. Besides, I doubt the
> > reverse operation is always efficient on platforms where hardware
> > cannot help reverse bit strings. Hence I'm working on the new hash
> > table algorithm, which, of course, is built on top of the linked list
> > we are working on :-).
>
> That makes a lot of sense. Re-hasing is indeed the main feature missing
> from rculfhash. I have ideas on how it could be introduced within the
> current split-ordered implementation with only small changes.
>
> One possibility would be to create two lists (rather than one): the
> current list, and a second list that would be used when a re-hasing
> is performed. The old list would be used by readers while re-hashing
> is in progress, and add/del would take care of both lists when done
> concurrently with re-hashing. After re-hasing is complete, the old
> list would not be used anymore after a grace period has passed.
>
> The cost of this approach is to have two next pointers per node (rather
> than one).

Agree. And we need to customize a linked list to allow each node to contain
two next pointers, before the hash table algorithm can use the list.

>
> An alternative would be to add a temporary layer of indirection when the
> re-hasing is performed. The "next" pointer would actually point to an
> intermediate object which contains the chaining information for both the
> old and the new lists. This would save the cost of the additional next
> pointer within each node, at the expense of doing extra temporary memory
> allocation when doing the re-hashing.
>

Great suggestion! One benefit is that we may reuse a lock-free linked list
without any modifications. If I understand correctly, the overall memory
consumption with this approach is slightly larger than that of the previous
one, because, in rehashing, each node has one intermediate node followed.
Is that right?

> I'd also be curious to see benchmarks of the bit-reversal compared to the
> rest of the operations needed for lookup, addition, and removal in a
> lock-free hash table for the main architectures that matter today.
> What architectures do you care about ?
>

Would be very happy to take a look at this and let you know the results
soon. BTW, I was thinking that some architectures (e.g., x86) could have
special instructions to help us accelerate the bit-reversal. Unfortunately,
I searched on google today and can't find the exact instruction to do this.
The most related instructions I found was at
https://en.wikipedia.org/wiki/Bit_Manipulation_Instruction_Sets . Do you
know the x86 instructions that can reverse bit strings? Thanks.

> I'm also curious to see what new hash table algorithm you have in mind!
>

I will write down the algorithm and send it to you soon.


Thanks,
--Junchang

> Thanks,
>
> Mathieu
>
>
> >
> > Thanks,
> > --Junchang
> >
> >> Thanks,
> >>
> >> Mathieu
> >>
> >>
> >> >
> >> > This singly linked list is based on the following research paper:
> >> > - Maged M. Michael. High performance dynamic lock-free hash tables
> >> >   and list-based sets. In Proceedings of the fourteenth annual ACM
> >> >   symposium on Parallel algorithms and architectures, ACM Press,
> >> >   (2002), 73-82.
> >> >
> >> > And we made the following two major improvements:
> >> > (1) Insert, Delete, and Find operations are protected by RCU
read_lock,
> >> >     such that the existence guarantees are provided by the RCU
mechanism,
> >> >     and that no special memory management schemes (e.g., hazard
pointers)
> >> >     is required anymore.
> >> > (2) The use of the RCU mechanism can naturally prevent the ABA
problem,
> >> >     such that no flag field is required in this implementation.
Hence,
> >> >     we save a variable of 8 bytes (typically sizeof(long)) for each
node.
> >> >
> >> > In the past two weeks, I found some bugs in the first version of the
> >> > list in building a lock-free hash table on top it. So this is the
second
> >> > version which fixes the known issues. Please review this version, if
> >> > possible. The major changes are as follows. Sorry for the
inconvenience.
> >> > Any suggestions and comments are warmly welcome.
> >> >
> >> > v1 -> v2:
> >> >  - Functions insert(), delete(), and find() return 0 in success, and
> >> >    return -Exxx otherwise.
> >> >  - Fix a bug in function is_removed().
> >> >
> >> > Cheers,
> >> > --Junchang
> >> >
> >> > Junchang Wang (4):
> >> >  userspace-rcu: Add lock-free singly linked list rculflist
> >> >  userspace-rcu: Add sample code of rculflist
> >> >  userspace-rcu: Update Makefile.am to include rculflist into the
> >> >    project
> >> >  userspace-rcu: Add a brief description of rculflist in cds-api.md
> >> >
> >> > doc/cds-api.md                                     |   7 +
> >> > doc/examples/rculflist/Makefile                    |  24 ++
> >> > .../rculflist/Makefile.cds_lflist_delete_rcu       |  21 ++
> >> > .../rculflist/Makefile.cds_lflist_find_rcu         |  21 ++
> >> > .../rculflist/Makefile.cds_lflist_insert_rcu       |  21 ++
> >> > doc/examples/rculflist/cds_lflist_delete_rcu.c     | 101 ++++++++
> >> > doc/examples/rculflist/cds_lflist_find_rcu.c       |  96 +++++++
> >> > doc/examples/rculflist/cds_lflist_insert_rcu.c     |  69 +++++
> >> > include/Makefile.am                                |   1 +
> >> > include/urcu/cds.h                                 |   1 +
> >> > include/urcu/rculflist.h                           | 284
+++++++++++++++++++++
> >> > 11 files changed, 646 insertions(+)
> >> > create mode 100644 doc/examples/rculflist/Makefile
> >> > create mode 100644
doc/examples/rculflist/Makefile.cds_lflist_delete_rcu
> >> > create mode 100644
doc/examples/rculflist/Makefile.cds_lflist_find_rcu
> >> > create mode 100644
doc/examples/rculflist/Makefile.cds_lflist_insert_rcu
> >> > create mode 100644 doc/examples/rculflist/cds_lflist_delete_rcu.c
> >> > create mode 100644 doc/examples/rculflist/cds_lflist_find_rcu.c
> >> > create mode 100644 doc/examples/rculflist/cds_lflist_insert_rcu.c
> >> > create mode 100644 include/urcu/rculflist.h
> >> >
> >> > --
> >> > 1.8.3.1
> >> >
> >> > _______________________________________________
> >> > lttng-dev mailing list
> >> > lttng-dev@lists.lttng.org
> >> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >>
> >> --
> >> Mathieu Desnoyers
> >> EfficiOS Inc.
> >> http://www.efficios.com
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

--000000000000408328058f0c0775
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Mathieu,<br><br>Thanks a lot for the feedback. Please s=
ee below,<br><br>On Tue, Jul 30, 2019 at 11:15 PM Mathieu Desnoyers &lt;<a =
href=3D"mailto:mathieu.desnoyers@efficios.com">mathieu.desnoyers@efficios.c=
om</a>&gt; wrote:<br>&gt;<br>&gt; ----- On Jul 30, 2019, at 9:34 AM, Juncha=
ng Wang <a href=3D"mailto:junchangwang@gmail.com">junchangwang@gmail.com</a=
> wrote:<br>&gt;<br>&gt; &gt; On Mon, Jul 29, 2019 at 9:55 PM Mathieu Desno=
yers<br>&gt; &gt; &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com">mat=
hieu.desnoyers@efficios.com</a>&gt; wrote:<br>&gt; &gt;&gt;<br>&gt; &gt;&gt=
; ----- On Jul 29, 2019, at 9:35 AM, Junchang Wang <a href=3D"mailto:juncha=
ngwang@gmail.com">junchangwang@gmail.com</a> wrote:<br>&gt; &gt;&gt;<br>&gt=
; &gt;&gt; &gt; Hi Mathieu and the list,<br>&gt; &gt;&gt; &gt;<br>&gt; &gt;=
&gt; &gt; I&#39;m recently using userspace-rcu to build lock-free data stru=
ctures. Thanks for<br>&gt; &gt;&gt; &gt; sharing this excellent project!<br=
>&gt; &gt;&gt; &gt;<br>&gt; &gt;&gt; &gt; In building a hash table, I am lo=
oking for an ordered singly linked list<br>&gt; &gt;&gt; &gt; that is lock-=
free. It seems such a list is missing in userspace-rcu. I<br>&gt; &gt;&gt; =
&gt; discussed this with Paul in the mailing list of perfbook, and he kindl=
y<br>&gt; &gt;&gt; &gt; suggested me to submit my implementation to userspa=
ce-rcu. So here is the<br>&gt; &gt;&gt; &gt; RFC. Any comments and suggesti=
ons are warmly welcome.<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; One point worth m=
entioning: the rculfhash data structure (rcu lock-free hash<br>&gt; &gt;&gt=
; table) already implements such list internally. You might want to have a =
look<br>&gt; &gt;&gt; at it, and perhaps just lift out its implementation i=
nto a separate .c file<br>&gt; &gt;&gt; and header file so we can expose it=
s implementation publicly ?<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; Items are lin=
ked through the struct cds_lfht_node next field.<br>&gt; &gt;&gt;<br>&gt; &=
gt;&gt; The struct cds_lfht_iter is used as a iterator on the list.<br>&gt;=
 &gt;&gt;<br>&gt; &gt;&gt; struct cds_lfht tbl_oder, tbl_chunk and tbl_mmap=
 contain the<br>&gt; &gt;&gt; linked lists heads for each memory allocation=
 scheme.<br>&gt; &gt;<br>&gt; &gt; Hi Mathieu,<br>&gt; &gt;<br>&gt; &gt; Th=
anks for the note. I checked rculfhash today, and the list<br>&gt; &gt; imp=
lementation within rculfhash is indeed quite similar to the one I&#39;m<br>=
&gt; &gt; working on. I will check to see if we can merge the two versions =
and<br>&gt; &gt; provide an independent rculflist.<br>&gt;<br>&gt; Great!<b=
r>&gt;<br>&gt; &gt;<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; I&#39;m wondering why=
 you need to re-implement a hash table though. What is<br>&gt; &gt;&gt; mis=
sing from rculfhash to suit your needs ?<br>&gt; &gt;&gt;<br>&gt; &gt;<br>&=
gt; &gt; The major reason is that I want a hash table that can change its h=
ash<br>&gt; &gt; function on-the-fly. Split-ordered list is not adequate be=
cause it can<br>&gt; &gt; only increase/decrease the number of buckets. Bes=
ides, I doubt the<br>&gt; &gt; reverse operation is always efficient on pla=
tforms where hardware<br>&gt; &gt; cannot help reverse bit strings. Hence I=
&#39;m working on the new hash<br>&gt; &gt; table algorithm, which, of cour=
se, is built on top of the linked list<br>&gt; &gt; we are working on :-).<=
br>&gt;<br>&gt; That makes a lot of sense. Re-hasing is indeed the main fea=
ture missing<br>&gt; from rculfhash. I have ideas on how it could be introd=
uced within the<br>&gt; current split-ordered implementation with only smal=
l changes.<br>&gt;<br>&gt; One possibility would be to create two lists (ra=
ther than one): the<br>&gt; current list, and a second list that would be u=
sed when a re-hasing<br>&gt; is performed. The old list would be used by re=
aders while re-hashing<br>&gt; is in progress, and add/del would take care =
of both lists when done<br>&gt; concurrently with re-hashing. After re-hasi=
ng is complete, the old<br>&gt; list would not be used anymore after a grac=
e period has passed.<br>&gt;<br>&gt; The cost of this approach is to have t=
wo next pointers per node (rather<br>&gt; than one).<br><br>Agree. And we n=
eed to customize a linked list to allow each node to contain two next point=
ers, before the hash table algorithm can use the list.<br><br>&gt;<br>&gt; =
An alternative would be to add a temporary layer of indirection when the<br=
>&gt; re-hasing is performed. The &quot;next&quot; pointer would actually p=
oint to an<br>&gt; intermediate object which contains the chaining informat=
ion for both the<br>&gt; old and the new lists. This would save the cost of=
 the additional next<br>&gt; pointer within each node, at the expense of do=
ing extra temporary memory<br>&gt; allocation when doing the re-hashing.<br=
>&gt;<br><br>Great suggestion! One benefit is that we may reuse a lock-free=
 linked list without any modifications. If I understand correctly, the over=
all memory consumption with this approach is slightly larger than that of t=
he previous one, because, in rehashing, each node has one intermediate node=
 followed. Is that right?<br><br>&gt; I&#39;d also be curious to see benchm=
arks of the bit-reversal compared to the<br>&gt; rest of the operations nee=
ded for lookup, addition, and removal in a<br>&gt; lock-free hash table for=
 the main architectures that matter today.<br>&gt; What architectures do yo=
u care about ?<br>&gt;<br><br>Would be very happy to take a look at this an=
d let you know the results soon. BTW, I was thinking that some architecture=
s (e.g., x86) could have special instructions to help us accelerate the bit=
-reversal. Unfortunately, I searched on google today and can&#39;t find the=
 exact instruction to do this. The most related instructions I found was at=
 <a href=3D"https://en.wikipedia.org/wiki/Bit_Manipulation_Instruction_Sets=
">https://en.wikipedia.org/wiki/Bit_Manipulation_Instruction_Sets</a>=C2=A0=
. Do you know the x86 instructions that can reverse bit strings? Thanks.<br=
><br>&gt; I&#39;m also curious to see what new hash table algorithm you hav=
e in mind!<br>&gt;<div><br></div><div>I will write down the algorithm and s=
end it to you soon.</div><div><br></div><div><br></div><div>Thanks,</div><d=
iv>--Junchang</div><div><br>&gt; Thanks,<br>&gt;<br>&gt; Mathieu<br>&gt;<br=
>&gt;<br>&gt; &gt;<br>&gt; &gt; Thanks,<br>&gt; &gt; --Junchang<br>&gt; &gt=
;<br>&gt; &gt;&gt; Thanks,<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; Mathieu<br>&gt=
; &gt;&gt;<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; &gt;<br>&gt; &gt;&gt; &gt; Thi=
s singly linked list is based on the following research paper:<br>&gt; &gt;=
&gt; &gt; - Maged M. Michael. High performance dynamic lock-free hash table=
s<br>&gt; &gt;&gt; &gt; =C2=A0 and list-based sets. In Proceedings of the f=
ourteenth annual ACM<br>&gt; &gt;&gt; &gt; =C2=A0 symposium on Parallel alg=
orithms and architectures, ACM Press,<br>&gt; &gt;&gt; &gt; =C2=A0 (2002), =
73-82.<br>&gt; &gt;&gt; &gt;<br>&gt; &gt;&gt; &gt; And we made the followin=
g two major improvements:<br>&gt; &gt;&gt; &gt; (1) Insert, Delete, and Fin=
d operations are protected by RCU read_lock,<br>&gt; &gt;&gt; &gt; =C2=A0 =
=C2=A0 such that the existence guarantees are provided by the RCU mechanism=
,<br>&gt; &gt;&gt; &gt; =C2=A0 =C2=A0 and that no special memory management=
 schemes (e.g., hazard pointers)<br>&gt; &gt;&gt; &gt; =C2=A0 =C2=A0 is req=
uired anymore.<br>&gt; &gt;&gt; &gt; (2) The use of the RCU mechanism can n=
aturally prevent the ABA problem,<br>&gt; &gt;&gt; &gt; =C2=A0 =C2=A0 such =
that no flag field is required in this implementation. Hence,<br>&gt; &gt;&=
gt; &gt; =C2=A0 =C2=A0 we save a variable of 8 bytes (typically sizeof(long=
)) for each node.<br>&gt; &gt;&gt; &gt;<br>&gt; &gt;&gt; &gt; In the past t=
wo weeks, I found some bugs in the first version of the<br>&gt; &gt;&gt; &g=
t; list in building a lock-free hash table on top it. So this is the second=
<br>&gt; &gt;&gt; &gt; version which fixes the known issues. Please review =
this version, if<br>&gt; &gt;&gt; &gt; possible. The major changes are as f=
ollows. Sorry for the inconvenience.<br>&gt; &gt;&gt; &gt; Any suggestions =
and comments are warmly welcome.<br>&gt; &gt;&gt; &gt;<br>&gt; &gt;&gt; &gt=
; v1 -&gt; v2:<br>&gt; &gt;&gt; &gt; =C2=A0- Functions insert(), delete(), =
and find() return 0 in success, and<br>&gt; &gt;&gt; &gt; =C2=A0 =C2=A0retu=
rn -Exxx otherwise.<br>&gt; &gt;&gt; &gt; =C2=A0- Fix a bug in function is_=
removed().<br>&gt; &gt;&gt; &gt;<br>&gt; &gt;&gt; &gt; Cheers,<br>&gt; &gt;=
&gt; &gt; --Junchang<br>&gt; &gt;&gt; &gt;<br>&gt; &gt;&gt; &gt; Junchang W=
ang (4):<br>&gt; &gt;&gt; &gt; =C2=A0userspace-rcu: Add lock-free singly li=
nked list rculflist<br>&gt; &gt;&gt; &gt; =C2=A0userspace-rcu: Add sample c=
ode of rculflist<br>&gt; &gt;&gt; &gt; =C2=A0userspace-rcu: Update Makefile=
.am to include rculflist into the<br>&gt; &gt;&gt; &gt; =C2=A0 =C2=A0projec=
t<br>&gt; &gt;&gt; &gt; =C2=A0userspace-rcu: Add a brief description of rcu=
lflist in cds-api.md<br>&gt; &gt;&gt; &gt;<br>&gt; &gt;&gt; &gt; doc/cds-ap=
i.md =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 7 +<br>&gt=
; &gt;&gt; &gt; doc/examples/rculflist/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A024 ++<br>&gt; &gt;&gt; &g=
t; .../rculflist/Makefile.cds_lflist_delete_rcu =C2=A0 =C2=A0 =C2=A0 | =C2=
=A021 ++<br>&gt; &gt;&gt; &gt; .../rculflist/Makefile.cds_lflist_find_rcu =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A021 ++<br>&gt; &gt;&gt; &gt; .../rculfli=
st/Makefile.cds_lflist_insert_rcu =C2=A0 =C2=A0 =C2=A0 | =C2=A021 ++<br>&gt=
; &gt;&gt; &gt; doc/examples/rculflist/cds_lflist_delete_rcu.c =C2=A0 =C2=
=A0 | 101 ++++++++<br>&gt; &gt;&gt; &gt; doc/examples/rculflist/cds_lflist_=
find_rcu.c =C2=A0 =C2=A0 =C2=A0 | =C2=A096 +++++++<br>&gt; &gt;&gt; &gt; do=
c/examples/rculflist/cds_lflist_insert_rcu.c =C2=A0 =C2=A0 | =C2=A069 +++++=
<br>&gt; &gt;&gt; &gt; include/Makefile.am =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| =C2=A0 1 +<br>&gt; &gt;&gt; &gt; include/urcu/cds.h =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 1 +<br>&gt; &gt;&gt; &gt; include/urcu/rc=
ulflist.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 284 +++++++++++++++++++++<br>&gt; &gt;&gt; &g=
t; 11 files changed, 646 insertions(+)<br>&gt; &gt;&gt; &gt; create mode 10=
0644 doc/examples/rculflist/Makefile<br>&gt; &gt;&gt; &gt; create mode 1006=
44 doc/examples/rculflist/Makefile.cds_lflist_delete_rcu<br>&gt; &gt;&gt; &=
gt; create mode 100644 doc/examples/rculflist/Makefile.cds_lflist_find_rcu<=
br>&gt; &gt;&gt; &gt; create mode 100644 doc/examples/rculflist/Makefile.cd=
s_lflist_insert_rcu<br>&gt; &gt;&gt; &gt; create mode 100644 doc/examples/r=
culflist/cds_lflist_delete_rcu.c<br>&gt; &gt;&gt; &gt; create mode 100644 d=
oc/examples/rculflist/cds_lflist_find_rcu.c<br>&gt; &gt;&gt; &gt; create mo=
de 100644 doc/examples/rculflist/cds_lflist_insert_rcu.c<br>&gt; &gt;&gt; &=
gt; create mode 100644 include/urcu/rculflist.h<br>&gt; &gt;&gt; &gt;<br>&g=
t; &gt;&gt; &gt; --<br>&gt; &gt;&gt; &gt; 1.8.3.1<br>&gt; &gt;&gt; &gt;<br>=
&gt; &gt;&gt; &gt; _______________________________________________<br>&gt; =
&gt;&gt; &gt; lttng-dev mailing list<br>&gt; &gt;&gt; &gt; <a href=3D"mailt=
o:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><br>&gt; &gt;&gt;=
 &gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=
">https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>&gt; &g=
t;&gt;<br>&gt; &gt;&gt; --<br>&gt; &gt;&gt; Mathieu Desnoyers<br>&gt; &gt;&=
gt; EfficiOS Inc.<br>&gt; &gt;&gt; <a href=3D"http://www.efficios.com">http=
://www.efficios.com</a><br>&gt; &gt; ______________________________________=
_________<br>&gt; &gt; lttng-dev mailing list<br>&gt; &gt; <a href=3D"mailt=
o:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><br>&gt; &gt; <a =
href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev">https:/=
/lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>&gt;<br>&gt; --<=
br>&gt; Mathieu Desnoyers<br>&gt; EfficiOS Inc.<br>&gt; <a href=3D"http://w=
ww.efficios.com">http://www.efficios.com</a></div></div>

--000000000000408328058f0c0775--

--===============2208686943243493489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2208686943243493489==--
