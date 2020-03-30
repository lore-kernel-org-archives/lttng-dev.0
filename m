From: Rocky Dunlap via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: babletrace2 graph performance considerations
Date: Mon, 30 Mar 2020 11:30:58 -0600
Message-ID: <CADtyBo7EBkHsDv-=-94oFnuviFvHnYQW_R6vHv08QCfo8QTyqg@mail.gmail.com>
References: <CADtyBo6B4YQ++VPhM4-cAfKYq0otJMg4zMXvQYqyNw3JsSX6Nw@mail.gmail.com>
 <9b2fe91b-4f44-3b89-eaf9-98f945384a33@simark.ca>
Reply-To: Rocky Dunlap <dunlap@ucar.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7597661519201398626=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by lists.lttng.org (Postfix) with ESMTPS id 48rfdH6Q3xz1Z2l
 for <lttng-dev@lists.lttng.org>; Mon, 30 Mar 2020 13:31:15 -0400 (EDT)
Received: by mail-ot1-x32d.google.com with SMTP id 111so18935855oth.13
 for <lttng-dev@lists.lttng.org>; Mon, 30 Mar 2020 10:31:15 -0700 (PDT)
In-Reply-To: <9b2fe91b-4f44-3b89-eaf9-98f945384a33@simark.ca>
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

--===============7597661519201398626==
Content-Type: multipart/alternative; boundary="0000000000005aeb7605a215d18d"

--0000000000005aeb7605a215d18d
Content-Type: text/plain; charset="UTF-8"

Simon,

Thanks - see below,

On Mon, Mar 30, 2020 at 7:32 AM Simon Marchi <simark@simark.ca> wrote:

> On 2020-03-30 12:10 a.m., Rocky Dunlap via lttng-dev wrote:
> > A couple of questions on performance considerations when setting up bt2
> processing graphs.
> >
> > 1.  Do parts of the processing graph that can execute concurrently do
> so?  Does the user have any control over this, e.g., by creating threads in
> sink components?
>
> The graph execution in itself is single-threaded at the moment.  We could
> imaging
> a design where different parts of the graph execute concurrently, in
> different
> threads, but it's the the case right now.
>
> You could make your components spawn threads to do some processing on the
> side,
> if that helps, but these other threads should not interact directly with
> the
> graph.
>

In my case I have CTF trace where some analyses can be performed on a
per-stream basis (no need to mux the streams together).  In this case, I
was thinking that it would make sense to thread over the streams.  However,
I think can easily do this at a level above the graph simply by creating
multiple graphs where each one is handling a single stream.  In my case I
am thinking this will be mostly I/O bound, so I'm not sure what kind of
payoff the threads will give.  Overall, I just want to make sure that I am
not doing anything that would, in the long run, preclude
threading/concurrency if it is added to the graph model itself.


>
> > 2.  It looks like you cannot connect one output port to multiple
> inputs.  Is there a way to create a tee component?
>
> Yes, we have discussed making a tee component, it is on the roadmap but
> not really
> planned yet.  It should be possible, it's just not as trivial as it may
> sound.
>
> One easy way to achieve it is to make each iterator that is created on the
> tee
> component create and maintain its own upstream iterator.  If you have a
> tee with
> two outputs, this will effectively make it so you have two graphs
> executing in
> parallel.  If you have a src.ctf.fs source upstream of the tee, then there
> will
> be two iterators created on that source, so the CTF trace will be open and
> decoded
> twice.  We'd like to avoid that.
>
> The other way of doing it is to make the tee buffer messages, and discard a
> message once all downstream iterators have consumed it.  This has some more
> difficult technical challenges, like what to do when one downstream
> iterator
> consumes, but the other does not (we don't want to buffer an infinite
> amount
> of data).  It also makes seeking a bit tricky.
>
> We could go in more details, if you are interested in starting
> implementing it
> yourself.
>

Yea, I can see how this can get tricky.  This is not critical at this very
moment, but I just wondered if there was a precedent for how to do this
kind of thing.


>
> Simon
>

--0000000000005aeb7605a215d18d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Simon,<div><br></div><div>Thanks - see be=
low,</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gm=
ail_attr">On Mon, Mar 30, 2020 at 7:32 AM Simon Marchi &lt;<a href=3D"mailt=
o:simark@simark.ca">simark@simark.ca</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On 2020-03-30 12:10 a.m., Rocky Dunlap =
via lttng-dev wrote:<br>
&gt; A couple of questions on performance considerations when setting up bt=
2 processing graphs.<br>
&gt; <br>
&gt; 1.=C2=A0 Do parts of the processing graph that can execute concurrentl=
y do so?=C2=A0 Does the user have any control over this, e.g., by creating =
threads in sink components?<br>
<br>
The graph execution in itself is single-threaded at the moment.=C2=A0 We co=
uld imaging<br>
a design where different parts of the graph execute concurrently, in differ=
ent<br>
threads, but it&#39;s the the case right now.<br>
<br>
You could make your components spawn threads to do some processing on the s=
ide,<br>
if that helps, but these other threads should not interact directly with th=
e<br>
graph.<br></blockquote><div><br></div><div>In my case I have CTF trace wher=
e some analyses can be performed on a per-stream basis (no need to mux the =
streams together).=C2=A0 In this case, I was thinking that it would make se=
nse to thread over the streams.=C2=A0 However, I think can easily do this a=
t a level above the graph simply by creating multiple graphs where each one=
 is handling a single stream.=C2=A0 In my case I am thinking this will be m=
ostly I/O bound, so I&#39;m not sure what kind of payoff the threads will g=
ive.=C2=A0 Overall, I just want to make sure that I am not doing anything t=
hat would, in the long run, preclude threading/concurrency if it is added t=
o the graph model itself.</div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
<br>
&gt; 2.=C2=A0 It looks like you cannot connect one output port to multiple =
inputs.=C2=A0 Is there a way to create a tee component?<br>
<br>
Yes, we have discussed making a tee component, it is on the roadmap but not=
 really<br>
planned yet.=C2=A0 It should be possible, it&#39;s just not as trivial as i=
t may sound.<br>
<br>
One easy way to achieve it is to make each iterator that is created on the =
tee<br>
component create and maintain its own upstream iterator.=C2=A0 If you have =
a tee with<br>
two outputs, this will effectively make it so you have two graphs executing=
 in<br>
parallel.=C2=A0 If you have a src.ctf.fs source upstream of the tee, then t=
here will<br>
be two iterators created on that source, so the CTF trace will be open and =
decoded<br>
twice.=C2=A0 We&#39;d like to avoid that.<br>
<br>
The other way of doing it is to make the tee buffer messages, and discard a=
<br>
message once all downstream iterators have consumed it.=C2=A0 This has some=
 more<br>
difficult technical challenges, like what to do when one downstream iterato=
r<br>
consumes, but the other does not (we don&#39;t want to buffer an infinite a=
mount<br>
of data).=C2=A0 It also makes seeking a bit tricky.<br>
<br>
We could go in more details, if you are interested in starting implementing=
 it<br>
yourself.<br></blockquote><div><br></div><div>Yea, I can see how this can g=
et tricky.=C2=A0 This is not critical at this very moment, but I just wonde=
red if there was a precedent for how to do this kind of thing.</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Simon<br>
</blockquote></div></div>

--0000000000005aeb7605a215d18d--

--===============7597661519201398626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7597661519201398626==--
