From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Deadlock in call_rcu_thread when destroy rculfhash
 node with nested rculfhash
Date: Thu, 1 Jun 2017 13:01:21 +0000 (UTC)
Message-ID: <5908376.2670.1496322081960.JavaMail.zimbra__49162.5897041105$1496322043$gmane$org@efficios.com>
References: <CAO6Ho0ea+Mhdoea4b3EL-J4z2wifHPWohq1ps74LQBU+b0-OOQ@mail.gmail.com>
 <CAO6Ho0e27-JTmUPrTRZfr95Lm=ri+mOSRNr7Av5Ma0t1ucuH6g@mail.gmail.com>
 <85898265.59079.1476889412542.JavaMail.zimbra@efficios.com>
 <CAO6Ho0d+LkJi_2ebomx13D42CApEG-bakyTbtzvz+Jvxc4wy9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1975198317383176315=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3wdnXt1Wm6z11Pg
 for <lttng-dev@lists.lttng.org>; Thu,  1 Jun 2017 13:01:33 +0000 (UTC)
In-Reply-To: <CAO6Ho0d+LkJi_2ebomx13D42CApEG-bakyTbtzvz+Jvxc4wy9A@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Evgeniy Ivanov <i@eivanov.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1975198317383176315==
Content-Type: multipart/alternative;
	boundary="=_9fd680d9-7eb8-475b-b9f2-8eefed163fa0"

--=_9fd680d9-7eb8-475b-b9f2-8eefed163fa0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Oct 21, 2016, at 4:19 AM, Evgeniy Ivanov <i@eivanov.com> wrote: 

> On Wed, Oct 19, 2016 at 6:03 PM, Mathieu Desnoyers < [
> mailto:mathieu.desnoyers@efficios.com | mathieu.desnoyers@efficios.com ] >
> wrote:

>> This is because we use call_rcu internally to trigger the hash table
>> resize.

>> In cds_lfht_destroy, we start by waiting for "in-flight" resize to complete.
>> Unfortunately, this requires that call_rcu worker thread progresses. If
>> cds_lfht_destroy is called from the call_rcu worker thread, it will wait
>> forever.

>> One alternative would be to implement our own worker thread scheme
>> for the rcu HT resize rather than use the call_rcu worker thread. This
>> would simplify cds_lfht_destroy requirements a lot.

>> Ideally I'd like to re-use all the call_rcu work dispatch/worker handling
>> scheme, just as a separate work queue.

>> Thoughts ?

> Thank you for explaining. Sounds like a plan: in our prod there is no issue with
> having extra thread for table resizes. And nested tables is important feature.

I finally managed to find some time to implement a solution, feedback 
would be welcome! 

Here are the RFC patches: 

https://lists.lttng.org/pipermail/lttng-dev/2017-May/027183.html 
https://lists.lttng.org/pipermail/lttng-dev/2017-May/027184.html 

Thanks, 

Mathieu 

>> Thanks,

>> Mathieu

>> ----- On Oct 19, 2016, at 6:03 AM, Evgeniy Ivanov < [ mailto:i@eivanov.com |
>> i@eivanov.com ] > wrote:

>>> Sorry, found partial answer in docs which state that cds_lfht_destroy should not
>>> be called from a call_rcu thread context. Why does this limitation exists?

>>> On Wed, Oct 19, 2016 at 12:56 PM, Evgeniy Ivanov < [ mailto:i@eivanov.com |
>>> i@eivanov.com ] > wrote:

>>>> Hi,

>>>> Each node of top level rculfhash has nested rculfhash. Some thread clears the
>>>> top level map and then uses rcu_barrier() to wait until everything is destroyed
>>>> (it is done to check leaks). Recently it started to dead lock sometimes with
>>>> following stacks:

>>>> Thread1:

>>>> __poll
>>>> cds_lfht_destroy <---- nested map
>>>> ...
>>>> free_Node(rcu_head*) <----- node of top level map
>>>> call_rcu_thread

>>>> Thread2:

>>>> syscall
>>>> rcu_barrier_qsbr
>>>> destroy_all
>>>> main

>>>> Did call_rcu_thread dead lock with barrier thread? Or is it some kind of
>>>> internal deadlock because of nested maps?

>>>> --
>>>> Cheers,
>>>> Evgeniy

>>> --
>>> Cheers,
>>> Evgeniy

>>> _______________________________________________
>>> lttng-dev mailing list
>>> [ mailto:lttng-dev@lists.lttng.org | lttng-dev@lists.lttng.org ]
>>> [ https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev |
>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev ]

>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> [ http://www.efficios.com/ | http://www.efficios.com ]

>> _______________________________________________
>> lttng-dev mailing list
>> [ mailto:lttng-dev@lists.lttng.org | lttng-dev@lists.lttng.org ]
>> [ https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev |
>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev ]

> --
> Cheers,
> Evgeniy

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_9fd680d9-7eb8-475b-b9f2-8eefed163fa0
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Oct 21, 2016, at 4:19 AM, Evgeniy Ivanov &lt;i@eivanov.com&gt;=
 wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockquote st=
yle=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color=
:#000;font-weight:normal;font-style:normal;text-decoration:none;font-family=
:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div class=3D=
"gmail_extra"><div class=3D"gmail_quote">On Wed, Oct 19, 2016 at 6:03 PM, M=
athieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@=
efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</spa=
n> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div><div st=
yle=3D"font-family:arial,helvetica,sans-serif;font-size:12pt;color:rgb(0,0,=
0)"><div>This is because we use call_rcu internally to trigger the hash tab=
le<br></div><div>resize.<br></div><br><div>In cds_lfht_destroy, we start by=
 waiting for "in-flight" resize to complete.<br></div><div>Unfortunately, t=
his requires that call_rcu worker thread progresses. If<br></div><div>cds_l=
fht_destroy is called from the call_rcu worker thread, it will wait<br></di=
v><div>forever.<br></div><br><div>One alternative would be to implement our=
 own worker thread scheme<br></div><div>for the rcu HT resize rather than u=
se the call_rcu worker thread. This</div><div>would simplify cds_lfht_destr=
oy requirements a lot.<br></div><br><div>Ideally I'd like to re-use all the=
 call_rcu work dispatch/worker handling<br></div><div>scheme, just as a sep=
arate work queue.<br></div><br><div>Thoughts ?<br></div></div></div></block=
quote><br><div>Thank you for explaining. Sounds like a plan: in our prod th=
ere is no issue with having extra thread for table resizes. And nested tabl=
es is important feature.<br></div></div></div></div></blockquote><div>I fin=
ally managed to find some time to implement a solution, feedback<br></div><=
div>would be welcome!<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=
=3D"1"></div><div>Here are the RFC patches:<br data-mce-bogus=3D"1"></div><=
div><br data-mce-bogus=3D"1"></div><div>https://lists.lttng.org/pipermail/l=
ttng-dev/2017-May/027183.html<br data-mce-bogus=3D"1"></div><div>https://li=
sts.lttng.org/pipermail/lttng-dev/2017-May/027184.html<br data-mce-bogus=3D=
"1"></div><div><br data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogu=
s=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-=
bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div><br data-mce-bog=
us=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"bor=
der-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font=
-weight:normal;font-style:normal;text-decoration:none;font-family:Helvetica=
,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div class=3D"gmail_ext=
ra"><div class=3D"gmail_quote"><br><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div><div style=3D"font-family:arial,helvetica,sans-serif;font-s=
ize:12pt;color:rgb(0,0,0)"><div><span style=3D"font-family:arial,sans-serif=
;font-size:small;color:rgb(34,34,34)">&nbsp;</span><br></div></div></div></=
blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div><div styl=
e=3D"font-family:arial,helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)=
"><div>Thanks,<br></div><br><div>Mathieu<br></div><div><div class=3D"gmail-=
h5"><br><span id=3D"gmail-m_1548600653268589583zwchr">----- On Oct 19, 2016=
, at 6:03 AM, Evgeniy Ivanov &lt;<a href=3D"mailto:i@eivanov.com" target=3D=
"_blank">i@eivanov.com</a>&gt; wrote:<br></span></div></div><div><blockquot=
e style=3D"border-left:2px solid rgb(16,16,255);margin-left:5px;padding-lef=
t:5px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration=
:none;font-family:helvetica,arial,sans-serif;font-size:12pt"><div><div clas=
s=3D"gmail-h5"><div dir=3D"ltr">Sorry, found partial answer in docs which s=
tate that&nbsp;cds_lfht_destroy should not be called&nbsp;from a call_rcu t=
hread context. Why does this limitation exists?</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Wed, Oct 19, 2016 at 12:56 PM, Evgen=
iy Ivanov <span dir=3D"ltr">&lt;<a href=3D"mailto:i@eivanov.com" target=3D"=
_blank">i@eivanov.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex"><div dir=3D"ltr">Hi,<br><br>Each node of top level rc=
ulfhash has nested rculfhash. Some thread clears the top level map and then=
 uses rcu_barrier() to wait until everything is destroyed (it is done to ch=
eck leaks). Recently it started to dead lock sometimes with following stack=
s:<br><br>Thread1:<br><span style=3D"font-family:monospace,monospace"><br><=
/span><div><span style=3D"font-family:monospace,monospace">__poll<br>cds_lf=
ht_destroy &nbsp; &nbsp;&lt;---- nested map<br>...<br>free_Node(rcu_head*) =
&nbsp;&lt;----- node of top level map<br>call_rcu_thread<br></span><br>Thre=
ad2:<div><br><span style=3D"font-family:monospace,monospace">syscall <br>rc=
u_barrier_qsbr <br>destroy_all<br>main<br></span><br><br>Did&nbsp;call_rcu_=
thread dead lock with barrier thread? Or is it some kind of internal deadlo=
ck because of nested maps?<span class=3D"gmail-m_1548600653268589583HOEnZb"=
><span style=3D"color:rgb(136,136,136)"><br><br><br>-- <br>Cheers,<br>Evgen=
iy</span></span></div></div></div></blockquote></div><br><br clear=3D"all">=
<br>-- <br><div class=3D"gmail-m_1548600653268589583gmail_signature">Cheers=
,<br>Evgeniy</div></div><br></div></div>___________________________________=
____________<br>lttng-dev mailing list<br><a href=3D"mailto:lttng-dev@lists=
.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a><br><a href=3D"h=
ttps://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" target=3D"_blank=
">https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><span class=
=3D"gmail-HOEnZb"><span style=3D"color: #888888;" data-mce-style=3D"color: =
#888888;" color=3D"#888888"><br></span></span></blockquote></div><span clas=
s=3D"gmail-HOEnZb"><span style=3D"color: #888888;" data-mce-style=3D"color:=
 #888888;" color=3D"#888888"><br><div>-- <br></div><div>Mathieu Desnoyers<b=
r>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D"_blank">ht=
tp://www.efficios.com</a><br data-mce-bogus=3D"1"></div></span></span></div=
></div><br>_______________________________________________<br>
lttng-dev mailing list<br><a href=3D"mailto:lttng-dev@lists.lttng.org" targ=
et=3D"_blank">lttng-dev@lists.lttng.org</a><br><a href=3D"https://lists.ltt=
ng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_bl=
ank">https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br><br>=
</blockquote></div><br><br clear=3D"all"><br>-- <br><div class=3D"gmail_sig=
nature">Cheers,<br>Evgeniy</div></div></div><br>___________________________=
____________________<br>lttng-dev mailing list<br>lttng-dev@lists.lttng.org=
<br>https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></blockqu=
ote></div><div><br></div><div data-marker=3D"__SIG_POST__">-- <br></div><di=
v>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</div></div>=
</body></html>
--=_9fd680d9-7eb8-475b-b9f2-8eefed163fa0--

--===============1975198317383176315==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============1975198317383176315==--
