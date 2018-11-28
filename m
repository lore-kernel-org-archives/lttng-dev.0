From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: making liburcu and lttng coexist in a LGPL'ed
 program
Date: Wed, 28 Nov 2018 17:06:43 -0500 (EST)
Message-ID: <1340598393.14672.1543442803749.JavaMail.zimbra__34383.3539671779$1543442698$gmane$org@efficios.com>
References: <5fcdce0f9a2ed1f6e1337db191f3b97e872a8e2f.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 434vrW1tjLzvK7
 for <lttng-dev@lists.lttng.org>; Wed, 28 Nov 2018 17:06:51 -0500 (EST)
In-Reply-To: <5fcdce0f9a2ed1f6e1337db191f3b97e872a8e2f.camel@redhat.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, =?utf-8?Q?Genevi=C3=A8ve?= Bastien <genevieve.bastien@polymtl.ca>, Thomas Serlin <tserlin@redhat.com>, devel@lists.nfs-ganesha.org
List-Id: lttng-dev@lists.lttng.org

----- On Nov 27, 2018, at 1:17 PM, Jeff Layton jlayton@redhat.com wrote:

> The nfs-ganesha project has used lttng for quite some time to handle
> tracing. Recently though, we decided to start building liburcu in as a
> mandatory component, with an eye toward using it in certain areas.
> 
> Before this change, the code linked in liburcu-bp directly, but now we
> just use liburcu. Unfortunately, when we enable tracepoints in the build
> now, we get errors like this at link time:
> 
> --------------------8<----------------
> [ 96%] Linking C executable ganesha.nfsd
> /usr/bin/ld: libMainServices.a(nfs_worker_thread.c.o): undefined reference to
> symbol 'rcu_gp_bp'
> /usr/bin/ld: //usr/lib64/liburcu-bp.so.6: error adding symbols: DSO missing from
> command line
> collect2: error: ld returned 1 exit status
> make[2]: *** [MainNFSD/CMakeFiles/ganesha.nfsd.dir/build.make:308:
> MainNFSD/ganesha.nfsd] Error 1
> make[1]: *** [CMakeFiles/Makefile2:2740:
> MainNFSD/CMakeFiles/ganesha.nfsd.dir/all] Error 2
> make: *** [Makefile:152: all] Error 2
> --------------------8<----------------
> 
> nfs-ganesha defines _LGPL_SOURCE, and that makes lttng use the
> redefinitions in tracepoint-rcu.h. If I disable _LGPL_SOURCE, it all
> builds as expected.
> 
> I found a similar bug here:
> 
>    https://bugs.lttng.org/issues/1156
> 
> Any thoughts on the right fix for this? We'd like to eat our cake and
> have it too, so that we can have _LGPL_SOURCE defined, lttng enabled,
> and the urcu flavor be determined at runtime.

Hi!

It's great to hear that feedback. Indeed you are not the first one
to hit this unfortunate limitation of liburcu API.

The use-case involves using many liburcu flavors within the same
compile unit _with_ _LGPL_SOURCE defined. All the tricks done
in urcu/map/*.h to map all flavors to a single API conflict
with that use-case. And the fact that the "mb", memb", and
signal flavors all share the same header prevents this
even further. This becomes a real issue when trying to use
the lttng-ust tracer instrumentation (which includes urcu-bp.h)
along with other liburcu flavors in a compile unit.

So, I took the day to hack something out: beware, it's a complete
overhaul of the liburcu tree. You can try it out in this private
development branch:

https://github.com/compudj/userspace-rcu-dev/tree/multiflavor

Note: don't even try to follow the git commit history at the
moment, this will need editing. ;)

A new unit test shows how it works:

https://github.com/compudj/userspace-rcu-dev/blob/multiflavor/tests/unit/test_urcu_multiflavor_single_unit.c

And while I was there, I did a lot of namespacing cleanups for the
APIs, so we'll _definitely_ need to bump the major soname for this.
However, I'm keeping the main use-cases of the API backward compatible
(those which relied on the API mapping). Here is a dev branch of
lttng-ust adapting to those API changes:

https://github.com/compudj/lttng-ust-dev/tree/urcu-multiflavor

Those who want to be able to use many liburcu flavors in a single
compile unit would need to define URCU_NO_API_MAP, and use each flavor
namespace directly, as done in the new unit test. I'm not particularly
fond of the URCU_NO_API_MAP name. We could perhaps name it "URCU_MULTI_FLAVOR"
or something else...

Please try it out and let me know how it goes.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
