From: Denis Yevgenyevich <denis.yevgenyevich@gmail.com>
Subject: Re: [liburcu] rculfhash autoresizing creates huge tables
Date: Wed, 28 Mar 2018 13:13:50 +0300
Message-ID: <CA+prXCGfEbyioWNZELa4BC38gPoPrytLjrEFxd+RDtx4NSjkSg__10884.4351991594$1522247084$gmane$org@mail.gmail.com>
References: <CA+prXCGNcY4n51hxQMCPDbs_5zUvG2SfURfFgd7eSDwjr4b_kQ@mail.gmail.com>
 <530644299.98.1522078357992.JavaMail.zimbra@efficios.com>
 <CA+prXCHWPUUrQW_doETZaBO4eMasjCJ9QgEGmODJ=NPf=H6CDQ@mail.gmail.com>
 <689232617.1005.1522155750694.JavaMail.zimbra@efficios.com>
 <CA+prXCFh8nhv_H-koPZRFMsCgKePGQTG3q-mrY4ffb_FtaRybA@mail.gmail.com>
 <792877887.1312.1522167428053.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0000000000007637f205687643ac"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yb0-x244.google.com (mail-yb0-x244.google.com
 [IPv6:2607:f8b0:4002:c09::244])
 by lists.lttng.org (Postfix) with ESMTPS id 40B3cv666MzxK3
 for <lttng-dev@lists.lttng.org>; Wed, 28 Mar 2018 06:13:51 -0400 (EDT)
Received: by mail-yb0-x244.google.com with SMTP id k8-v6so595888ybd.6
 for <lttng-dev@lists.lttng.org>; Wed, 28 Mar 2018 03:13:51 -0700 (PDT)
In-Reply-To: <792877887.1312.1522167428053.JavaMail.zimbra@efficios.com>
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

--0000000000007637f205687643ac
Content-Type: multipart/alternative; boundary="0000000000007637ee05687643aa"

--0000000000007637ee05687643aa
Content-Type: text/plain; charset="UTF-8"

> Actually, this is not the average chain length: the resize happens when
the first chain going
> beyond the threshold is encountered. I would expect the average chain
length to be somewhere
> below that threshold. It would be interesting if you could provide
insight into the distribution of
> your hash table bucket chain length by adding instrumentation code.
Please have a look at the attached files. I printed out histograms <chain
length: frequency>
right before and after each _do_cds_lfht_resize(). The average chain length
computed as
items / buckets exceeded 8. Each millisecond I was adding a unique item in
the table.
The test was run twice with different hash functions, siphash (64-bit) and
lookup3 (32-bit).

Chains that long are ok, I think, until tables get huge and most node
accesses
during a lookup become cache misses.

> > Perhaps you could make CHAIN_LEN_RESIZE_THRESHOLD a tunable?
> That would be a possibility, yes. Would you like to propose a patch ?
Perhaps later, too busy.

On 27 March 2018 at 19:17, Mathieu Desnoyers <mathieu.desnoyers@efficios.com
> wrote:

> (Please keep the lttng-dev mailing list in CC.)
>
> ----- On Mar 27, 2018, at 12:07 PM, Denis Yevgenyevich
> denis.yevgenyevich@gmail.com wrote:
>
> >> When both flags are set, check_resize() is only for the bucket-local
> chain
> > > length algorithm that deals
> >> with very small tables. Then, when the table size goes above that
> threshold,
> > > split-counters are used to
> >> adjust the required table size. We don't use the split-counters
> approximation of
> > > the number of elements
> >> in the table for small tables because they are not accurate enough for
> small
> > > tables. It's a tradeoff
> > > between accuracy and accounting overhead here.
> > Thanks for the explanation.
>
> >> Notice that ht_count_add() and ht_count_del() both invoke
> > > cds_lfht_resize_lazy_count(). It's that
> > > function which is responsible for the split-counter based resize
> algorithm.
> >> If both (CDS_LFHT_ACCOUNTING | CDS_LFHT_AUTO_RESIZE) flags are set, the
> table
> > > will
> > > still grow after it has gone beyond this condition.
> > That's what I overlooked. I've just repeated my test, letting it run for
> a
> > longer time.
> > After 4096 items (4-core cpu) check_resize() stopped growing the table.
>
> 4096 buckets is indeed the threshold for a 4-core cpu system.
>
> > After 32768 items ht_cound_add() finally grew the table to 32768. That
> is when
> > the check
> > if ((count >> CHAIN_LEN_RESIZE_THRESHOLD) < size)
> > went false. The average chain length might have been 8 by that time.
> Isn't it
> > too much?
>
> Actually, this is not the average chain length: the resize happens when
> the first chain going
> beyond the threshold is encountered. I would expect the average chain
> length to be somewhere
> below that threshold. It would be interesting if you could provide insight
> into the distribution of
> your hash table bucket chain length by adding instrumentation code.
>
> > Perhaps you could make CHAIN_LEN_RESIZE_THRESHOLD a tunable?
>
> That would be a possibility, yes. Would you like to propose a patch ?
>
> > Anyway, I am glad now I understand how this stuff works. Thank you again!
>
> You're welcome!
>
> Thanks,
>
> Mathieu
>
> > On 27 March 2018 at 16:02, Mathieu Desnoyers < [
> > mailto:mathieu.desnoyers@efficios.com | mathieu.desnoyers@efficios.com
> ] >
> > wrote:
>
> >> ----- On Mar 27, 2018, at 5:55 AM, Denis Yevgenyevich < [
> >> mailto:denis.yevgenyevich@gmail.com | denis.yevgenyevich@gmail.com ] >
> wrote:
>
> >>>> The "accounting" option is meant to be enabled, otherwise you're
> using the hash
> >>> > table only with
> >>> > the bucket-length resize threshold, which has the imperfections you
> noticed
> >>> Well, given that my software has to maintain precise counts of items
> inserted
> >>> into some of hashtables,
> >>> I'd like to be able to avoid any performance overhead due to
> accounting.
>
> >>>> only for small tables. Beyond a certain size, the numbers of elements
> in the
> >>> > hash table are used
> >>> > as a criterion for resize.
> >>>> Why is it unexpected that the table stops growing beyond 4096 after
> 900
> >>> > insertions ?
> >>> Ah, thanks. Turns out that the table stopped growing because of the
> check
> >>> if (count >= (1UL << (COUNT_COMMIT_ORDER + split_count_order)))
>
> >> If both (CDS_LFHT_ACCOUNTING | CDS_LFHT_AUTO_RESIZE) flags are set, the
> table
> >> will
> >> still grow after it has gone beyond this condition.
>
> >> When both flags are set, check_resize() is only for the bucket-local
> chain
> >> length algorithm that deals
> >> with very small tables. Then, when the table size goes above that
> threshold,
> >> split-counters are used to
> >> adjust the required table size. We don't use the split-counters
> approximation of
> >> the number of elements
> >> in the table for small tables because they are not accurate enough for
> small
> >> tables. It's a tradeoff
> >> between accuracy and accounting overhead here.
>
> >> Notice that ht_count_add() and ht_count_del() both invoke
> >> cds_lfht_resize_lazy_count(). It's that
> >> function which is responsible for the split-counter based resize
> algorithm.
>
> >>> I am a bit disappointed about that. Why can't we have tables that
> resize
> >>> 1. automatically
> >>> 2. from 10s to 100,000s of buckets
> >>> 3. without becoming too large too soon?
>
> >> The only thing here is that the bucket-length algorithm used for small
> tables
> >> can grow the
> >> table more quickly than you would expect if you have hash collisions.
> But it
> >> should not
> >> matter that much because it only applies to small tables. Do you
> experience "too
> >> aggressive"
> >> hash table growth even beyond the threshold selecting the
> split-counters resize
> >> algorithm ?
>
> >> That threshold is calculated as:
>
> >> (1UL << (COUNT_COMMIT_ORDER + split_count_order)
>
> >> Where COUNT_COMMIT_ORDER = 10
> >> and split_count_order = log2(nr_cpus ceiled to next power of 2)
>
> >> Assuming a 64-core machine:
>
> >> log2(64) = 6
> >> 2 ^ (10 + 6) = 65536
>
> >> Considering that you created your hash table with an initial size of 16
> buckets,
> >> specified a minimum
> >> number of buckets of 16, and a maximum number of buckets of 1 << 16
> (65536),
> >> you'll always be
> >> using the "hash-chain length" algorithm for resize on a 64-core
> machine. The
> >> split-counter algorithm
> >> would never kick in.
>
> >> You should therefore try tweaking the @max_nr_buckets parameter to a
> larger
> >> value when
> >> calling cds_lfht_new().
>
> >> How many cores do you have ?
>
> >> Let me know how is goes,
>
> >> Thanks,
>
> >> Mathieu
>
> >>> On 26 March 2018 at 18:32, Mathieu Desnoyers < [
> >>> mailto:mathieu.desnoyers@efficios.com | mathieu.desnoyers@efficios.com
> ] >
> >>> wrote:
>
> >>>> ----- On Mar 26, 2018, at 11:01 AM, Denis Yevgenyevich < [
> >>>> mailto:denis.yevgenyevich@gmail.com | denis.yevgenyevich@gmail.com ]
> > wrote:
>
> >>>>> Hello,
>
> >>>>> I think rculfhash autoresizing (as enabled by CDS_LFHT_AUTO_RESIZE)
> does not
> >>>>> behave well. Each time _cds_lfht_add finds a hash bucket with more
> than 2
> >>>>> items, it basically tries to quadruple the hash table size. But even
> with a
> >>>>> perfect hash function hash collisions are not that rare, given a
> large enough
> >>>>> table. That is, every now and then the algorithm will come across a
> 3-long
> >>>>> chain and will grow the table unnecessarily.
>
> >>>>> I created a table with cds_lfht_new(16, 16, 1<<16,
> CDS_LFHT_AUTO_RESIZE, NULL)
> >>>>> and began adding an item each 10ms. Each item had a unique key and
> the hash
> >>>>> function was very good (full 64-bit values of Siphash). Judging by
> messages I
> >>>>> added to rculfhash.c, this was happening:
> >>>>> after about 100 insertions, the table was resized to 512
> >>>>> after about 500 insertions, the table was resized to 4096
> >>>>> after about 1300 insertions, the table was resized to 16384 and
> immediately to
> >>>>> 32768
>
> >>>>> With CDS_LFHT_AUTO_RESIZE|CDS_LFHT_ACCOUNTING the behaviour was
> different but
> >>>>> still unacceptable: the table got resized to 4096 after 900
> insertions and then
> >>>>> stopped growing!
>
> >>>> The "accounting" option is meant to be enabled, otherwise you're
> using the hash
> >>>> table only with
> >>>> the bucket-length resize threshold, which has the imperfections you
> noticed.
>
> >>>> With accounting enabled, the bucket length is used as an
> approximation for when
> >>>> resize is needed
> >>>> only for small tables. Beyond a certain size, the numbers of elements
> in the
> >>>> hash table are used
> >>>> as a criterion for resize.
>
> >>>> Why is it unexpected that the table stops growing beyond 4096 after
> 900
> >>>> insertions ? How many
> >>>> more insertions did you do beyond 900 ?
>
> >>>> Thanks,
>
> >>>> Mathieu
>
> >>>>> Could someone please implement saner resize conditions, or better
> yet, add a
> >>>>> customisable hook for decisions as to when and how much should a
> table grow?
>
> >>>>> Cheers, Denis.
>
> >>>>> _______________________________________________
> >>>>> lttng-dev mailing list
> >>>>> [ mailto:lttng-dev@lists.lttng.org | lttng-dev@lists.lttng.org ]
> >>>>> [ https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev |
> >>>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev ]
>
> >>>> --
> >>>> Mathieu Desnoyers
> >>>> EfficiOS Inc.
> >>>> [ http://www.efficios.com/ | http://www.efficios.com ]
>
> >> --
> >> Mathieu Desnoyers
> >> EfficiOS Inc.
> >> [ http://www.efficios.com/ | http://www.efficios.com ]
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--0000000000007637ee05687643aa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>&gt; Actually, this is not the average chain length: =
the resize happens when the first chain going<br>&gt; beyond the threshold =
is encountered. I would expect the average chain length to be somewhere<br>=
&gt; below that threshold. It would be interesting if you could provide ins=
ight into the distribution of<br>&gt; your hash table bucket chain length b=
y adding instrumentation code.<br>
</div><div><span class=3D"gmail-im">Please have a look at the attached file=
s. I printed out histograms &lt;chain length: frequency&gt;<br></span></div=
><div><span class=3D"gmail-im">right before and after each _do_cds_lfht_res=
ize(). The average chain length computed as<br>items / buckets exceeded 8. =
Each millisecond I was adding a unique item in the table.</span></div><div>=
<span class=3D"gmail-im">The test was run twice with different hash functio=
ns, siphash (64-bit) and lookup3 (32-bit).<br><br></span></div><div><span c=
lass=3D"gmail-im">Chains that long are ok, I think, until tables get huge a=
nd most node accesses<br>during a lookup become cache misses.<br></span></d=
iv><div><span class=3D"gmail-im"><br>
&gt; &gt; Perhaps you could make CHAIN_LEN_RESIZE_THRESHOLD a tunable?<br>
&gt; </span>That would be a possibility, yes. Would you like to propose a p=
atch ?<br></div>Perhaps later, too busy.<br></div><div class=3D"gmail_extra=
"><br><div class=3D"gmail_quote">On 27 March 2018 at 19:17, Mathieu Desnoye=
rs <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" =
target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</span> wrote:<br><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">(Please keep the lttng-dev mailing list in CC=
.)<br>
<span class=3D""><br>
----- On Mar 27, 2018, at 12:07 PM, Denis Yevgenyevich <a href=3D"mailto:de=
nis.yevgenyevich@gmail.com">denis.yevgenyevich@gmail.com</a> wrote:<br>
<br>
&gt;&gt; When both flags are set, check_resize() is only for the bucket-loc=
al chain<br>
&gt; &gt; length algorithm that deals<br>
&gt;&gt; with very small tables. Then, when the table size goes above that =
threshold,<br>
&gt; &gt; split-counters are used to<br>
&gt;&gt; adjust the required table size. We don&#39;t use the split-counter=
s approximation of<br>
&gt; &gt; the number of elements<br>
&gt;&gt; in the table for small tables because they are not accurate enough=
 for small<br>
&gt; &gt; tables. It&#39;s a tradeoff<br>
&gt; &gt; between accuracy and accounting overhead here.<br>
&gt; Thanks for the explanation.<br>
<br>
&gt;&gt; Notice that ht_count_add() and ht_count_del() both invoke<br>
&gt; &gt; cds_lfht_resize_lazy_count(). It&#39;s that<br>
&gt; &gt; function which is responsible for the split-counter based resize =
algorithm.<br>
&gt;&gt; If both (CDS_LFHT_ACCOUNTING | CDS_LFHT_AUTO_RESIZE) flags are set=
, the table<br>
&gt; &gt; will<br>
&gt; &gt; still grow after it has gone beyond this condition.<br>
&gt; That&#39;s what I overlooked. I&#39;ve just repeated my test, letting =
it run for a<br>
&gt; longer time.<br>
&gt; After 4096 items (4-core cpu) check_resize() stopped growing the table=
.<br>
<br>
</span>4096 buckets is indeed the threshold for a 4-core cpu system.<br>
<span class=3D""><br>
&gt; After 32768 items ht_cound_add() finally grew the table to 32768. That=
 is when<br>
&gt; the check<br>
&gt; if ((count &gt;&gt; CHAIN_LEN_RESIZE_THRESHOLD) &lt; size)<br>
&gt; went false. The average chain length might have been 8 by that time. I=
sn&#39;t it<br>
&gt; too much?<br>
<br>
</span>Actually, this is not the average chain length: the resize happens w=
hen the first chain going<br>
beyond the threshold is encountered. I would expect the average chain lengt=
h to be somewhere<br>
below that threshold. It would be interesting if you could provide insight =
into the distribution of<br>
your hash table bucket chain length by adding instrumentation code.<br>
<span class=3D""><br>
&gt; Perhaps you could make CHAIN_LEN_RESIZE_THRESHOLD a tunable?<br>
<br>
</span>That would be a possibility, yes. Would you like to propose a patch =
?<br>
<span class=3D""><br>
&gt; Anyway, I am glad now I understand how this stuff works. Thank you aga=
in!<br>
<br>
</span>You&#39;re welcome!<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<br>
&gt; On 27 March 2018 at 16:02, Mathieu Desnoyers &lt; [<br>
&gt; mailto:<a href=3D"mailto:mathieu.desnoyers@efficios.com">mathieu.desno=
yers@<wbr>efficios.com</a> | <a href=3D"mailto:mathieu.desnoyers@efficios.c=
om">mathieu.desnoyers@efficios.com</a> ] &gt;<br>
&gt; wrote:<br>
<br>
&gt;&gt; ----- On Mar 27, 2018, at 5:55 AM, Denis Yevgenyevich &lt; [<br>
<div><div class=3D"h5">&gt;&gt; mailto:<a href=3D"mailto:denis.yevgenyevich=
@gmail.com">denis.yevgenyevich@<wbr>gmail.com</a> | <a href=3D"mailto:denis=
.yevgenyevich@gmail.com">denis.yevgenyevich@gmail.com</a> ] &gt; wrote:<br>
<br>
&gt;&gt;&gt;&gt; The &quot;accounting&quot; option is meant to be enabled, =
otherwise you&#39;re using the hash<br>
&gt;&gt;&gt; &gt; table only with<br>
&gt;&gt;&gt; &gt; the bucket-length resize threshold, which has the imperfe=
ctions you noticed<br>
&gt;&gt;&gt; Well, given that my software has to maintain precise counts of=
 items inserted<br>
&gt;&gt;&gt; into some of hashtables,<br>
&gt;&gt;&gt; I&#39;d like to be able to avoid any performance overhead due =
to accounting.<br>
<br>
&gt;&gt;&gt;&gt; only for small tables. Beyond a certain size, the numbers =
of elements in the<br>
&gt;&gt;&gt; &gt; hash table are used<br>
&gt;&gt;&gt; &gt; as a criterion for resize.<br>
&gt;&gt;&gt;&gt; Why is it unexpected that the table stops growing beyond 4=
096 after 900<br>
&gt;&gt;&gt; &gt; insertions ?<br>
&gt;&gt;&gt; Ah, thanks. Turns out that the table stopped growing because o=
f the check<br>
&gt;&gt;&gt; if (count &gt;=3D (1UL &lt;&lt; (COUNT_COMMIT_ORDER + split_co=
unt_order)))<br>
<br>
&gt;&gt; If both (CDS_LFHT_ACCOUNTING | CDS_LFHT_AUTO_RESIZE) flags are set=
, the table<br>
&gt;&gt; will<br>
&gt;&gt; still grow after it has gone beyond this condition.<br>
<br>
&gt;&gt; When both flags are set, check_resize() is only for the bucket-loc=
al chain<br>
&gt;&gt; length algorithm that deals<br>
&gt;&gt; with very small tables. Then, when the table size goes above that =
threshold,<br>
&gt;&gt; split-counters are used to<br>
&gt;&gt; adjust the required table size. We don&#39;t use the split-counter=
s approximation of<br>
&gt;&gt; the number of elements<br>
&gt;&gt; in the table for small tables because they are not accurate enough=
 for small<br>
&gt;&gt; tables. It&#39;s a tradeoff<br>
&gt;&gt; between accuracy and accounting overhead here.<br>
<br>
&gt;&gt; Notice that ht_count_add() and ht_count_del() both invoke<br>
&gt;&gt; cds_lfht_resize_lazy_count(). It&#39;s that<br>
&gt;&gt; function which is responsible for the split-counter based resize a=
lgorithm.<br>
<br>
&gt;&gt;&gt; I am a bit disappointed about that. Why can&#39;t we have tabl=
es that resize<br>
&gt;&gt;&gt; 1. automatically<br>
&gt;&gt;&gt; 2. from 10s to 100,000s of buckets<br>
&gt;&gt;&gt; 3. without becoming too large too soon?<br>
<br>
&gt;&gt; The only thing here is that the bucket-length algorithm used for s=
mall tables<br>
&gt;&gt; can grow the<br>
&gt;&gt; table more quickly than you would expect if you have hash collisio=
ns. But it<br>
&gt;&gt; should not<br>
&gt;&gt; matter that much because it only applies to small tables. Do you e=
xperience &quot;too<br>
&gt;&gt; aggressive&quot;<br>
&gt;&gt; hash table growth even beyond the threshold selecting the split-co=
unters resize<br>
&gt;&gt; algorithm ?<br>
<br>
&gt;&gt; That threshold is calculated as:<br>
<br>
&gt;&gt; (1UL &lt;&lt; (COUNT_COMMIT_ORDER + split_count_order)<br>
<br>
&gt;&gt; Where COUNT_COMMIT_ORDER =3D 10<br>
&gt;&gt; and split_count_order =3D log2(nr_cpus ceiled to next power of 2)<=
br>
<br>
&gt;&gt; Assuming a 64-core machine:<br>
<br>
&gt;&gt; log2(64) =3D 6<br>
&gt;&gt; 2 ^ (10 + 6) =3D 65536<br>
<br>
&gt;&gt; Considering that you created your hash table with an initial size =
of 16 buckets,<br>
&gt;&gt; specified a minimum<br>
&gt;&gt; number of buckets of 16, and a maximum number of buckets of 1 &lt;=
&lt; 16 (65536),<br>
&gt;&gt; you&#39;ll always be<br>
&gt;&gt; using the &quot;hash-chain length&quot; algorithm for resize on a =
64-core machine. The<br>
&gt;&gt; split-counter algorithm<br>
&gt;&gt; would never kick in.<br>
<br>
&gt;&gt; You should therefore try tweaking the @max_nr_buckets parameter to=
 a larger<br>
&gt;&gt; value when<br>
&gt;&gt; calling cds_lfht_new().<br>
<br>
&gt;&gt; How many cores do you have ?<br>
<br>
&gt;&gt; Let me know how is goes,<br>
<br>
&gt;&gt; Thanks,<br>
<br>
&gt;&gt; Mathieu<br>
<br>
</div></div>&gt;&gt;&gt; On 26 March 2018 at 18:32, Mathieu Desnoyers &lt; =
[<br>
&gt;&gt;&gt; mailto:<a href=3D"mailto:mathieu.desnoyers@efficios.com">mathi=
eu.desnoyers@<wbr>efficios.com</a> | <a href=3D"mailto:mathieu.desnoyers@ef=
ficios.com">mathieu.desnoyers@efficios.com</a> ] &gt;<br>
&gt;&gt;&gt; wrote:<br>
<br>
&gt;&gt;&gt;&gt; ----- On Mar 26, 2018, at 11:01 AM, Denis Yevgenyevich &lt=
; [<br>
<div><div class=3D"h5">&gt;&gt;&gt;&gt; mailto:<a href=3D"mailto:denis.yevg=
enyevich@gmail.com">denis.yevgenyevich@<wbr>gmail.com</a> | <a href=3D"mail=
to:denis.yevgenyevich@gmail.com">denis.yevgenyevich@gmail.com</a> ] &gt; wr=
ote:<br>
<br>
&gt;&gt;&gt;&gt;&gt; Hello,<br>
<br>
&gt;&gt;&gt;&gt;&gt; I think rculfhash autoresizing (as enabled by CDS_LFHT=
_AUTO_RESIZE) does not<br>
&gt;&gt;&gt;&gt;&gt; behave well. Each time _cds_lfht_add finds a hash buck=
et with more than 2<br>
&gt;&gt;&gt;&gt;&gt; items, it basically tries to quadruple the hash table =
size. But even with a<br>
&gt;&gt;&gt;&gt;&gt; perfect hash function hash collisions are not that rar=
e, given a large enough<br>
&gt;&gt;&gt;&gt;&gt; table. That is, every now and then the algorithm will =
come across a 3-long<br>
&gt;&gt;&gt;&gt;&gt; chain and will grow the table unnecessarily.<br>
<br>
&gt;&gt;&gt;&gt;&gt; I created a table with cds_lfht_new(16, 16, 1&lt;&lt;1=
6, CDS_LFHT_AUTO_RESIZE, NULL)<br>
&gt;&gt;&gt;&gt;&gt; and began adding an item each 10ms. Each item had a un=
ique key and the hash<br>
&gt;&gt;&gt;&gt;&gt; function was very good (full 64-bit values of Siphash)=
. Judging by messages I<br>
&gt;&gt;&gt;&gt;&gt; added to rculfhash.c, this was happening:<br>
&gt;&gt;&gt;&gt;&gt; after about 100 insertions, the table was resized to 5=
12<br>
&gt;&gt;&gt;&gt;&gt; after about 500 insertions, the table was resized to 4=
096<br>
&gt;&gt;&gt;&gt;&gt; after about 1300 insertions, the table was resized to =
16384 and immediately to<br>
&gt;&gt;&gt;&gt;&gt; 32768<br>
<br>
&gt;&gt;&gt;&gt;&gt; With CDS_LFHT_AUTO_RESIZE|CDS_LFHT_<wbr>ACCOUNTING the=
 behaviour was different but<br>
&gt;&gt;&gt;&gt;&gt; still unacceptable: the table got resized to 4096 afte=
r 900 insertions and then<br>
&gt;&gt;&gt;&gt;&gt; stopped growing!<br>
<br>
&gt;&gt;&gt;&gt; The &quot;accounting&quot; option is meant to be enabled, =
otherwise you&#39;re using the hash<br>
&gt;&gt;&gt;&gt; table only with<br>
&gt;&gt;&gt;&gt; the bucket-length resize threshold, which has the imperfec=
tions you noticed.<br>
<br>
&gt;&gt;&gt;&gt; With accounting enabled, the bucket length is used as an a=
pproximation for when<br>
&gt;&gt;&gt;&gt; resize is needed<br>
&gt;&gt;&gt;&gt; only for small tables. Beyond a certain size, the numbers =
of elements in the<br>
&gt;&gt;&gt;&gt; hash table are used<br>
&gt;&gt;&gt;&gt; as a criterion for resize.<br>
<br>
&gt;&gt;&gt;&gt; Why is it unexpected that the table stops growing beyond 4=
096 after 900<br>
&gt;&gt;&gt;&gt; insertions ? How many<br>
&gt;&gt;&gt;&gt; more insertions did you do beyond 900 ?<br>
<br>
&gt;&gt;&gt;&gt; Thanks,<br>
<br>
&gt;&gt;&gt;&gt; Mathieu<br>
<br>
&gt;&gt;&gt;&gt;&gt; Could someone please implement saner resize conditions=
, or better yet, add a<br>
&gt;&gt;&gt;&gt;&gt; customisable hook for decisions as to when and how muc=
h should a table grow?<br>
<br>
&gt;&gt;&gt;&gt;&gt; Cheers, Denis.<br>
<br>
&gt;&gt;&gt;&gt;&gt; ______________________________<wbr>_________________<b=
r>
&gt;&gt;&gt;&gt;&gt; lttng-dev mailing list<br>
</div></div>&gt;&gt;&gt;&gt;&gt; [ mailto:<a href=3D"mailto:lttng-dev@lists=
.lttng.org">lttng-dev@lists.lttng.<wbr>org</a> | <a href=3D"mailto:lttng-de=
v@lists.lttng.org">lttng-dev@lists.lttng.org</a> ]<br>
&gt;&gt;&gt;&gt;&gt; [ <a href=3D"https://lists.lttng.org/cgi-bin/mailman/l=
istinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">https://lists.lttng=
.org/cgi-<wbr>bin/mailman/listinfo/lttng-dev</a> |<br>
<span class=3D"">&gt;&gt;&gt;&gt;&gt; <a href=3D"https://lists.lttng.org/cg=
i-bin/mailman/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">http=
s://lists.lttng.org/cgi-<wbr>bin/mailman/listinfo/lttng-dev</a> ]<br>
<br>
&gt;&gt;&gt;&gt; --<br>
&gt;&gt;&gt;&gt; Mathieu Desnoyers<br>
&gt;&gt;&gt;&gt; EfficiOS Inc.<br>
</span>&gt;&gt;&gt;&gt; [ <a href=3D"http://www.efficios.com/" rel=3D"noref=
errer" target=3D"_blank">http://www.efficios.com/</a> | <a href=3D"http://w=
ww.efficios.com" rel=3D"noreferrer" target=3D"_blank">http://www.efficios.c=
om</a> ]<br>
<span class=3D""><br>
&gt;&gt; --<br>
&gt;&gt; Mathieu Desnoyers<br>
&gt;&gt; EfficiOS Inc.<br>
</span>&gt;&gt; [ <a href=3D"http://www.efficios.com/" rel=3D"noreferrer" t=
arget=3D"_blank">http://www.efficios.com/</a> | <a href=3D"http://www.effic=
ios.com" rel=3D"noreferrer" target=3D"_blank">http://www.efficios.com</a> ]=
<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
--<br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" rel=3D"noreferrer" target=3D"_blank">ht=
tp://www.efficios.com</a><br>
</div></div></blockquote></div><br></div>

--0000000000007637ee05687643aa--

--0000000000007637f205687643ac
Content-Type: text/plain; charset="US-ASCII"; name="siphash.log"
Content-Disposition: attachment; filename="siphash.log"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jfawvsa20

Ozs7IC0tLS0tLS0tLS0tLS0tLS0tCiAwOiAgICAgMgogMTogICAgIDMKIDI6ICAgICAzCiAzOiAg
ICAgNAogNDogICAgIDIKIDU6ICAgICAyCjs7OyAzOSBpdGVtcywgMTYgYnVja2V0cywgYXZnLmxl
biAyLjQ0Cjs7OyBSQ1UgR1JPV0lORyAxNiBUTyA2NAoKIDA6ICAgIDM0CiAxOiAgICAxOQogMjog
ICAgMTEKOzs7IDQxIGl0ZW1zLCA2NCBidWNrZXRzLCBhdmcubGVuIDAuNjQKOzs7IFJDVSBSRVNJ
WkVEIFRPIDY0Cgo7OzsgLS0tLS0tLS0tLS0tLS0tLS0KIDA6ICAgIDE1CiAxOiAgICAxNgogMjog
ICAgMTQKIDM6ICAgIDEzCiA0OiAgICAgNAogNTogICAgIDIKOzs7IDEwOSBpdGVtcywgNjQgYnVj
a2V0cywgYXZnLmxlbiAxLjcwCjs7OyBSQ1UgR1JPV0lORyA2NCBUTyAyNTYKCiAwOiAgIDQxNQog
MTogICAgODUKIDI6ICAgIDEwCiAzOiAgICAgMgo7OzsgMTExIGl0ZW1zLCA1MTIgYnVja2V0cywg
YXZnLmxlbiAwLjIyCjs7OyBSQ1UgUkVTSVpFRCBUTyA1MTIKCjs7OyAtLS0tLS0tLS0tLS0tLS0t
LQogMDogICAyOTUKIDE6ICAgMTU1CiAyOiAgICA0OQogMzogICAgMTAKIDQ6ICAgICAxCiA1OiAg
ICAgMAogNjogICAgIDIKOzs7IDI5OSBpdGVtcywgNTEyIGJ1Y2tldHMsIGF2Zy5sZW4gMC41OAo7
OzsgUkNVIEdST1dJTkcgNTEyIFRPIDQwOTYKCiAwOiAgMzgwNwogMTogICAyNzkKIDI6ICAgIDEw
Cjs7OyAyOTkgaXRlbXMsIDQwOTYgYnVja2V0cywgYXZnLmxlbiAwLjA3Cjs7OyBSQ1UgUkVTSVpF
RCBUTyA0MDk2Cgo7OzsgLS0tLS0tLS0tLS0tLS0tLS0KIDA6ICAgICA0CiAxOiAgICAgOQogMjog
ICAgMjgKIDM6ICAgIDg1CiA0OiAgIDE5MgogNTogICAyOTcKIDY6ICAgNDE1CiA3OiAgIDU0NAog
ODogICA1MjgKIDk6ICAgNTk2CjEwOiAgIDQ1MAoxMTogICAzMjIKMTI6ICAgMjcwCjEzOiAgIDE2
MQoxNDogICAgOTUKMTU6ICAgIDQ5CjE2OiAgICAyMwoxNzogICAgMTEKMTg6ICAgIDEwCjE5OiAg
ICAgNQoyMDogICAgIDEKMjE6ICAgICAwCjIyOiAgICAgMQo7OzsgMzQ3NzEgaXRlbXMsIDQwOTYg
YnVja2V0cywgYXZnLmxlbiA4LjQ5Cjs7OyBSQ1UgR1JPV0lORyA0MDk2IFRPIDMyNzY4CgogMDog
MTEzMzgKIDE6IDEyMDU0CiAyOiAgNjM2MwogMzogIDIyMzUKIDQ6ICAgNjI3CiA1OiAgIDEyNQog
NjogICAgMjIKIDc6ICAgICA0Cjs7OyAzNDc3OCBpdGVtcywgMzI3NjggYnVja2V0cywgYXZnLmxl
biAxLjA2Cjs7OyBSQ1UgUkVTSVpFRCBUTyAzMjc2OAoKOzs7IC0tLS0tLS0tLS0tLS0tLS0tCiAw
OiAgICAxMQogMTogICAgODEKIDI6ICAgMzU3CiAzOiAgIDg1NAogNDogIDE4NDIKIDU6ICAyOTY4
CiA2OiAgMzg0NQogNzogIDQ1NjgKIDg6ICA0NTQ5CiA5OiAgNDIxMQoxMDogIDMzNTAKMTE6ICAy
MzM3CjEyOiAgMTY0OAoxMzogICA5NzMKMTQ6ICAgNTg0CjE1OiAgIDMwNwoxNjogICAxNTQKMTc6
ICAgIDc2CjE4OiAgICAzMAoxOTogICAgMTYKMjA6ICAgICA0CjIxOiAgICAgMgoyMjogICAgIDAK
MjM6ICAgICAxCjs7OyAyNjQwNjAgaXRlbXMsIDMyNzY4IGJ1Y2tldHMsIGF2Zy5sZW4gOC4wNgo7
OzsgUkNVIEdST1dJTkcgMzI3NjggVE8gMjYyMTQ0CgogMDogOTU2NTYKIDE6IDk2NDcwCiAyOiA0
ODU5NgogMzogMTYzOTUKIDQ6ICA0MDU3CiA1OiAgIDgwOAogNjogICAxNDMKIDc6ICAgIDE2CiA4
OiAgICAgMwo7OzsgMjY0MTA5IGl0ZW1zLCAyNjIxNDQgYnVja2V0cywgYXZnLmxlbiAxLjAxCjs7
OyBSQ1UgUkVTSVpFRCBUTyAyNjIxNDQK
--0000000000007637f205687643ac
Content-Type: text/plain; charset="US-ASCII"; name="lookup3.log"
Content-Disposition: attachment; filename="lookup3.log"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jfawwn451

Ozs7IC0tLS0tLS0tLS0tLS0tLS0tCiAwOiAgICAgMgogMTogICAgIDEKIDI6ICAgICAyCiAzOiAg
ICAgOQogNDogICAgIDEKIDU6ICAgICAwCiA2OiAgICAgMQo7OzsgNDIgaXRlbXMsIDE2IGJ1Y2tl
dHMsIGF2Zy5sZW4gMi42Mgo7OzsgUkNVIEdST1dJTkcgMTYgVE8gNjQKCiAwOiAgICA5MQogMTog
ICAgMzIKIDI6ICAgICA1Cjs7OyA0MiBpdGVtcywgMTI4IGJ1Y2tldHMsIGF2Zy5sZW4gMC4zMwo7
OzsgUkNVIFJFU0laRUQgVE8gMTI4Cgo7OzsgLS0tLS0tLS0tLS0tLS0tLS0KIDA6ICAgIDUyCiAx
OiAgICA0MgogMjogICAgMjYKIDM6ICAgICA3CiA0OiAgICAgMQo7OzsgMTE5IGl0ZW1zLCAxMjgg
YnVja2V0cywgYXZnLmxlbiAwLjkzCjs7OyBSQ1UgR1JPV0lORyAxMjggVE8gNTEyCgogMDogICA5
MTEKIDE6ICAgMTA3CiAyOiAgICAgNgo7OzsgMTE5IGl0ZW1zLCAxMDI0IGJ1Y2tldHMsIGF2Zy5s
ZW4gMC4xMgo7OzsgUkNVIFJFU0laRUQgVE8gMTAyNAoKOzs7IC0tLS0tLS0tLS0tLS0tLS0tCiAw
OiAgIDUzMQogMTogICAzNjIKIDI6ICAgMTAzCiAzOiAgICAyNgogNDogICAgIDIKOzs7IDY1NCBp
dGVtcywgMTAyNCBidWNrZXRzLCBhdmcubGVuIDAuNjQKOzs7IFJDVSBHUk9XSU5HIDEwMjQgVE8g
NDA5NgoKIDA6ICAzNDkyCiAxOiAgIDU1NQogMjogICAgNDgKIDM6ICAgICAxCjs7OyA2NTQgaXRl
bXMsIDQwOTYgYnVja2V0cywgYXZnLmxlbiAwLjE2Cjs7OyBSQ1UgUkVTSVpFRCBUTyA0MDk2Cgo7
OzsgLS0tLS0tLS0tLS0tLS0tLS0KIDA6ICAgICAyCiAxOiAgICAgNQogMjogICAgMzUKIDM6ICAg
IDc1CiA0OiAgIDE5OQogNTogICAzMTkKIDY6ICAgNDU4CiA3OiAgIDU1MAogODogICA1NjcKIDk6
ICAgNTEyCjEwOiAgIDQyOAoxMTogICAzODQKMTI6ICAgMjI5CjEzOiAgIDEzNwoxNDogICAgODkK
MTU6ICAgIDQ4CjE2OiAgICAyOAoxNzogICAgMTYKMTg6ICAgICA4CjE5OiAgICAgNAoyMDogICAg
IDIKMjE6ICAgICAwCjIyOiAgICAgMAoyMzogICAgIDEKOzs7IDM0NDM1IGl0ZW1zLCA0MDk2IGJ1
Y2tldHMsIGF2Zy5sZW4gOC40MQo7OzsgUkNVIEdST1dJTkcgNDA5NiBUTyAzMjc2OAoKIDA6IDEx
NDU3CiAxOiAxMTk4NAogMjogIDY0MTAKIDM6ICAyMjE5CiA0OiAgIDU0MgogNTogICAxMjEKIDY6
ICAgIDMwCiA3OiAgICAgNQo7OzsgMzQ0NDkgaXRlbXMsIDMyNzY4IGJ1Y2tldHMsIGF2Zy5sZW4g
MS4wNQo7OzsgUkNVIFJFU0laRUQgVE8gMzI3NjgKCjs7OyAtLS0tLS0tLS0tLS0tLS0tLQogMDog
ICAgMTAKIDE6ICAgIDgwCiAyOiAgIDMzNgogMzogICA5MDUKIDQ6ICAxNzg1CiA1OiAgMzAxOQog
NjogIDM5NjQKIDc6ICA0NTg3CiA4OiAgNDQ4NwogOTogIDQwOTMKMTA6ICAzMzI0CjExOiAgMjQ3
MAoxMjogIDE0NjgKMTM6ICAxMDA4CjE0OiAgIDYxMQoxNTogICAzMDkKMTY6ICAgMTc2CjE3OiAg
ICA3NwoxODogICAgMzUKMTk6ICAgIDE3CjIwOiAgICAgNQoyMTogICAgIDEKMjI6ICAgICAxCjs7
OyAyNjM4NjggaXRlbXMsIDMyNzY4IGJ1Y2tldHMsIGF2Zy5sZW4gOC4wNQo7OzsgUkNVIEdST1dJ
TkcgMzI3NjggVE8gMjYyMTQ0CgogMDogOTU3MzUKIDE6IDk2NTM5CiAyOiA0ODU0NAogMzogMTYx
ODAKIDQ6ICA0MTY3CiA1OiAgIDgwNwogNjogICAxNDgKIDc6ICAgIDIwCiA4OiAgICAgNAo7Ozsg
MjYzOTMwIGl0ZW1zLCAyNjIxNDQgYnVja2V0cywgYXZnLmxlbiAxLjAxCjs7OyBSQ1UgUkVTSVpF
RCBUTyAyNjIxNDQK
--0000000000007637f205687643ac
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--0000000000007637f205687643ac--
