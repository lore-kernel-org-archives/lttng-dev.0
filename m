From: Rocky Dunlap via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: bt2 python - accessing component instances added to
 graph
Date: Mon, 30 Mar 2020 14:41:00 -0600
Message-ID: <CADtyBo7c1-Ge+BbRGPG669woGZPiCfy5pfqrMHDF=aPfUWmU2g@mail.gmail.com>
References: <CADtyBo4tQxYBFZnk6dqTSkU4OjW2Fxmx0xJrP=ADaCz_YUXf1g@mail.gmail.com>
 <f07941b7-51ae-0f42-2a9b-abcf82e299de@simark.ca>
 <CADtyBo6mzBQ3sVUpc4gbxEf7LVsfV+m8oWNMjMdG1gDPsnRR6A@mail.gmail.com>
 <32146698-0314-1eaf-e422-2c9e088056e7@simark.ca>
Reply-To: Rocky Dunlap <dunlap@ucar.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6544851028592930151=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by lists.lttng.org (Postfix) with ESMTPS id 48rkrY5Rkrz1Ygf
 for <lttng-dev@lists.lttng.org>; Mon, 30 Mar 2020 16:41:17 -0400 (EDT)
Received: by mail-oi1-x230.google.com with SMTP id k18so16977677oib.3
 for <lttng-dev@lists.lttng.org>; Mon, 30 Mar 2020 13:41:17 -0700 (PDT)
In-Reply-To: <32146698-0314-1eaf-e422-2c9e088056e7@simark.ca>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Simon Marchi <simark@simark.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============6544851028592930151==
Content-Type: multipart/alternative; boundary="000000000000005cb705a21879db"

--000000000000005cb705a21879db
Content-Type: text/plain; charset="UTF-8"

(Adding the list back in - I meant to reply-all before...)

Simon,

Yes, the obj solution should work just fine - I was wondering about that
parameter and the approach makes sense to me.  Thanks!

Rocky

On Mon, Mar 30, 2020 at 2:38 PM Simon Marchi <simark@simark.ca> wrote:

> On 2020-03-30 4:24 p.m., Rocky Dunlap wrote:
> > Simon,
> >
> > In my case, after the graph completes, I was trying to access the sink
> instances in order to collect some statistics collected inside the instance
> during the graph run.  I guess then the question is how are the graph
> components supposed to communicate with the outside world in general, such
> as filling in some Python data structures with info from a trace for
> post-processing or further analysis in Python?  Or is the expectation that
> sink components will retain no state at all after the graph completes?
> >
> > Rocky
>
> Hi Rocky,
>
> Was it your intention to not do a reply-all?  I think this would be good
> info for all to read.  If not,
> please do a reply-all and I'll replay again what I wrote below on the list.
>
> Of course the sinks are expected to produce some result outside of their
> own little internal state.  For
> sinks that produce some trace files, they'll typically write on the
> filsystem (like sink.ctf.fs).
>
> But if you want to send some results to another Python object/data
> structure, the `obj` parameter of
> `add_component` is pretty much meant for that.  You can pass in a
> reference to a Python object, and
> the component receives it in its `__init__`.  We thought that this could
> be useful, for example, if
> the sink needs to receive a connection handle to a database, for example.
> That handle can be created
> outside of the sink and passed it when instantiating the component.  Think
> of it like some void* user
> data in C.
>
> In your case, you could create whatever object you need to collect your
> statistics/results, and pass
> a reference to it.
>
> Here's an example in the tests:
>
>
> https://github.com/efficios/babeltrace/blob/8b305066676fc7aa433e8eb668f9de8802008025/tests/bindings/python/bt2/test_graph.py#L106-L120
>
> Does that help?
>
> Simon
>

--000000000000005cb705a21879db
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>(Adding the list back in - I meant to reply-all befor=
e...)</div><div><br></div><div>Simon,</div><div><br>Yes, the obj solution s=
hould work just fine - I was wondering about that parameter and the approac=
h makes sense to me.=C2=A0 Thanks!</div><div><br></div><div>Rocky</div><br>=
<div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Ma=
r 30, 2020 at 2:38 PM Simon Marchi &lt;<a href=3D"mailto:simark@simark.ca">=
simark@simark.ca</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">On 2020-03-30 4:24 p.m., Rocky Dunlap wrote:<br>
&gt; Simon,<br>
&gt; <br>
&gt; In my case, after the graph completes, I was trying to access the sink=
 instances in order to collect some statistics collected inside the instanc=
e during the graph run.=C2=A0 I guess then the question is how are the grap=
h components supposed to communicate with the outside world in general, suc=
h as filling in some Python data structures with info from a trace for post=
-processing or further analysis in Python?=C2=A0 Or is the expectation=C2=
=A0that sink components will retain no state at all after the graph complet=
es?<br>
&gt; <br>
&gt; Rocky<br>
<br>
Hi Rocky,<br>
<br>
Was it your intention to not do a reply-all?=C2=A0 I think this would be go=
od info for all to read.=C2=A0 If not,<br>
please do a reply-all and I&#39;ll replay again what I wrote below on the l=
ist.<br>
<br>
Of course the sinks are expected to produce some result outside of their ow=
n little internal state.=C2=A0 For<br>
sinks that produce some trace files, they&#39;ll typically write on the fil=
system (like sink.ctf.fs).<br>
<br>
But if you want to send some results to another Python object/data structur=
e, the `obj` parameter of<br>
`add_component` is pretty much meant for that.=C2=A0 You can pass in a refe=
rence to a Python object, and<br>
the component receives it in its `__init__`.=C2=A0 We thought that this cou=
ld be useful, for example, if<br>
the sink needs to receive a connection handle to a database, for example.=
=C2=A0 That handle can be created<br>
outside of the sink and passed it when instantiating the component.=C2=A0 T=
hink of it like some void* user<br>
data in C.<br>
<br>
In your case, you could create whatever object you need to collect your sta=
tistics/results, and pass<br>
a reference to it.<br>
<br>
Here&#39;s an example in the tests:<br>
<br>
<a href=3D"https://github.com/efficios/babeltrace/blob/8b305066676fc7aa433e=
8eb668f9de8802008025/tests/bindings/python/bt2/test_graph.py#L106-L120" rel=
=3D"noreferrer" target=3D"_blank">https://github.com/efficios/babeltrace/bl=
ob/8b305066676fc7aa433e8eb668f9de8802008025/tests/bindings/python/bt2/test_=
graph.py#L106-L120</a><br>
<br>
Does that help?<br>
<br>
Simon<br>
</blockquote></div></div>

--000000000000005cb705a21879db--

--===============6544851028592930151==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6544851028592930151==--
