From: Mike Day <ncmike@ncultra.org>
Subject: Re: [RFC PATCH] Introduce RCU-enabled DQs (v2)
Date: Mon, 26 Aug 2013 17:48:12 -0400
Message-ID: <CAGaKXu1V5Cz+9b=v=HEt2kn=2sJiD+ORm_9SyB7v35zNXWWUOw@mail.gmail.com>
References: <1377371209-2017-1-git-send-email-ncmike@ncultra.org>
	<20130825191835.GA1073@Krystal>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=089e0149d0ac88833204e4e0b696
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <20130825191835.GA1073@Krystal>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: rp@svcs.cs.pdx.edu, qemu-devel@nongnu.org, lttng-dev@lists.lttng.org, Anthony Liguori <anthony@codemonkey.ws>, Paolo Bonzini <pbonzini@redhat.com>, Paul Mckenney <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

--089e0149d0ac88833204e4e0b696
Content-Type: text/plain; charset=ISO-8859-1

On Sun, Aug 25, 2013 at 3:18 PM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:
>
> I'm not very comfortable with your DQ implementation not providing any
> kind of guarantee to a forward traversal followed by backward traversal,
> nor for backward followed by forward traversal. If a list add is
> executed concurrently with traversals, and we can ensure there are no
> list del of the node, if a traversal sees the added node when doing
> forward iteration, I would clearly expect to still see it if a backward
> iteration follows.
>
> I took the liberty of implementing a couple of ideas I had to provide
> a RCU DQ with those guarantees. I just pushed the code here (beware, I
> just did some basic single-threaded unit tests so far, so consider this
> code as largely untested concurrency-wise):
>
>   git clone git://git.urcu.io/urcu.git
>   branch: rcudq
>   file: urcu/rcudq.h
>
> Direct link to the file via gitweb:
>
http://git.lttng.org/?p=userspace-rcu.git;a=blob;f=urcu/rcudq.h;h=4a8d7b0d5143a958514cf130b1c124d99f3194ca;hb=refs/heads/rcudq

Mathieu - Thanks for the review! And thanks for the code, I'm working with
it right now. I like the idea of using a flag to provide a form of
atomicity for the doubly-linked list elements. I'm also planning on running
some timing tests to see of the additional memory barriers and atomic
accesses make *any* difference whatsoever.

Mike

Mike Day | ncmike@ncultra.org | +1 919 371-8786

--089e0149d0ac88833204e4e0b696
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Sun, Aug 25, 2013 at 3:18 PM, Mathieu Desnoyers &lt;<a =
href=3D"mailto:mathieu.desnoyers@efficios.com">mathieu.desnoyers@efficios.c=
om</a>&gt; wrote:<br>&gt;<br>&gt; I&#39;m not very comfortable with your DQ=
 implementation not providing any<br>
&gt; kind of guarantee to a forward traversal followed by backward traversa=
l,<br>&gt; nor for backward followed by forward traversal. If a list add is=
<br>&gt; executed concurrently with traversals, and we can ensure there are=
 no<br>
&gt; list del of the node, if a traversal sees the added node when doing<br=
>&gt; forward iteration, I would clearly expect to still see it if a backwa=
rd<br>&gt; iteration follows.<br>&gt;<br>&gt; I took the liberty of impleme=
nting a couple of ideas I had to provide<br>
&gt; a RCU DQ with those guarantees. I just pushed the code here (beware, I=
<br>&gt; just did some basic single-threaded unit tests so far, so consider=
 this<br>&gt; code as largely untested concurrency-wise):<br>&gt;<br>&gt; =
=A0 git clone git://<a href=3D"http://git.urcu.io/urcu.git">git.urcu.io/urc=
u.git</a><br>
&gt; =A0 branch: rcudq<br>&gt; =A0 file: urcu/rcudq.h<br>&gt;<br>&gt; Direc=
t link to the file via gitweb:<br>&gt; =A0 <a href=3D"http://git.lttng.org/=
?p=3Duserspace-rcu.git;a=3Dblob;f=3Durcu/rcudq.h;h=3D4a8d7b0d5143a958514cf1=
30b1c124d99f3194ca;hb=3Drefs/heads/rcudq">http://git.lttng.org/?p=3Duserspa=
ce-rcu.git;a=3Dblob;f=3Durcu/rcudq.h;h=3D4a8d7b0d5143a958514cf130b1c124d99f=
3194ca;hb=3Drefs/heads/rcudq</a><br>
<br><div style>Mathieu - Thanks for the review! And thanks for the code, I&=
#39;m working with it right now. I like the idea of using a flag to provide=
 a form of atomicity for the doubly-linked list elements. I&#39;m also plan=
ning on running some timing tests to see of the additional memory barriers =
and atomic accesses make *any* difference whatsoever.=A0</div>
<div style><br></div><div style>Mike</div><div style><br></div><div style>M=
ike Day | <a href=3D"mailto:ncmike@ncultra.org">ncmike@ncultra.org</a> | +1=
 919 371-8786=A0</div></div>

--089e0149d0ac88833204e4e0b696--
