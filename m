From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH liburcu] Fix pthread_atfork() behaviour
Date: Thu, 17 Apr 2014 12:20:00 +0000 (UTC)
Message-ID: <1310479684.3385.1397737200900.JavaMail.zimbra__13549.4885304526$1397737295$gmane$org@efficios.com>
References: <534BE34D.6040304@cohodata.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=_Part_3382_1897829317.1397737200896"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1WalIX-0000ks-EW
 for lttng-dev@lists.lttng.org; Thu, 17 Apr 2014 08:20:22 -0400
In-Reply-To: <534BE34D.6040304@cohodata.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Keir Fraser <keir@cohodata.com>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

------=_Part_3382_1897829317.1397737200896
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- Original Message -----
> From: "Keir Fraser" <keir@cohodata.com>
> To: lttng-dev@lists.lttng.org
> Sent: Monday, April 14, 2014 9:31:57 AM
> Subject: [lttng-dev] [PATCH liburcu] Fix pthread_atfork() behaviour
> 
> In the process of integrating liburcu into a multi-threaded codebase
> with fork()s I found a couple of problems with liburcu that I could not
> work around without fixing the library. Hence I present the two required
> fixes here (as attachments, sorry!) with some background info about them.

This is interesting!

An initial question: Which URCU flavor are you using ?

> 
> After fork() the child process has no pthreads but the one that called
> fork(). Unfortunately call_rcu_after_fork_child() does not update URCU's
> thread registry to reflect this -- if fork() is called with any threads
> registered with URCU then the child process will inherit a corrupted
> registry containing a linked list through per-thread TLS state which is
> no longer valid allocated memory.

You appear to be using the mb/memb URCU flavor.

If we look at URCU README file:

Interaction with fork()

        Special care must be taken for applications performing fork() without
        any following exec(). This is caused by the fact that Linux only clones
        the thread calling fork(), and thus never replicates any of the other
        parent thread into the child process. Most liburcu implementations
        require that all registrations (as reader, defer_rcu and call_rcu
        threads) should be released before a fork() is performed, except for the
        rather common scenario where fork() is immediately followed by exec() in
        the child process. The only implementation not subject to that rule is
        liburcu-bp, which is designed to handle fork() by calling
        rcu_bp_before_fork, rcu_bp_after_fork_parent and
        rcu_bp_after_fork_child.

        Applications that use call_rcu() and that fork() without
        doing an immediate exec() must take special action.  The parent
        must invoke call_rcu_before_fork() before the fork() and
        call_rcu_after_fork_parent() after the fork().  The child
        process must invoke call_rcu_after_fork_child().
        Even though these three APIs are suitable for passing to
        pthread_atfork(), use of pthread_atfork() is *STRONGLY
        DISCOURAGED* for programs calling the glibc memory allocator
        (malloc(), calloc(), free(), ...) within call_rcu callbacks.
        This is due to limitations in the way glibc memory allocator
        handles calls to the memory allocator from concurrent threads
        while the pthread_atfork() handlers are executing.
        Combining e.g.:
        * call to free() from callbacks executed within call_rcu worker
          threads,
        * executing call_rcu atfork handlers within the glibc pthread
          atfork mechanism,
        will sometimes trigger interesting process hangs. This usually
        hangs on a memory allocator lock within glibc.


> Crash or hang soon after is the
> result. Patch 1 therefore simply clears the registry list in the child
> process. Caveats here are that (a) the calling thread cannot be
> registered (it must unregister/re-register itself in the atfork
> handlers); and (b) some flavours of URCU may have more complex
> registries than a simple linked list and so this patch may not be
> sufficient for those. I only tested the memb/mb flavour myself.

Firstly, your use-case seems to be only supported by the urcu-bp
flavor, and explicitly unsupported by other flavors. If you want
to do this with other urcu flavors, you need to explicitly
unregister all your other RCU threads before doing the fork().

Also, if we want to eventually support this in the other flavors,
we would need to implement the flavor-specific teardown within each
flavor implementation rather than in the call_rcu implementation.

Moreover, as stated in the README file, call_rcu() pre/post fork
handlers don't behave well with glibc's pthread_atfork(), due to
assumptions done within the glibc memory allocator.

> 
> A second problem is that although call_rcu threads are paused across
> fork(), the handshaking PAUSED flag is not cleared when their execution
> resumes. Hence a second fork() invocation in the original parent process
> will not spin-wait for call_rcu threads to quiesce (as the atfork
> handler will observe all PAUSED flags already set). Patch 2 fixes this
> with the appropriate clearing handshake on resume, post-fork.

I'd be very interested to see a test-case for this problem against
the urcu-bp flavor. I think you have indeed caught a real bug here.

> 
> Please feel free to modify or rewrite these patches, or solve the
> described problems in a different way, as you see fit! Cc me on replies
> as I am not a subscriber to this list.

Could you provide a small test-case that we could add to the call_rcu
regression (double fork) under tests/regression to make sure this behavior
is covered in the future ? A small refactoring of test_urcu_fork.c to
extend it should do the trick.

Thanks!

Mathieu

> 
>   Regards,
>   Keir Fraser
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

------=_Part_3382_1897829317.1397737200896
Content-Type: text/x-patch; name=1-zap-thread-registry.patch
Content-Disposition: attachment; filename=1-zap-thread-registry.patch
Content-Transfer-Encoding: base64

PkZyb20gMzA0NGIxNjBjOWU1NjE0Nzg3ZGI1ODkxZmIwZGVkOGE0YTFlZDEwOCBNb24gU2VwIDE3
IDAwOjAwOjAwIDIwMDENCkZyb206IEtlaXIgRnJhc2VyIDxrZWlyQGNvaG9kYXRhLmNvbT4NCkRh
dGU6IE1vbiwgNyBBcHIgMjAxNCAxNDoyMDozMyArMDEwMA0KU3ViamVjdDogW1BBVENIIDEvMl0g
Q2xlYW4gdGhlIHRocmVhZCByZWdpc3RyeSBpbiB0aGUgY2hpbGQgb2YgYSBmb3JrLg0KIE5vIHRo
cmVhZHMgYXJlIHJlZ2lzdGVyZWQgdGhlcmUsIGFuZCB0aGUgcmVnaXN0cnkgaXMgYSBsaW5rZWQg
bGlzdCB0aHJvdWdoDQogbm9uLWV4aXN0ZW50IHBlci10aHJlYWQgc3RhdGUuDQoNClRoZSBjYWxs
ZXIgb2YgdGhlIHB0aHJlYWRfYXRmb3JrKCkgaGFuZGxlcnMgbXVzdCBub3QgYmUgYW4gUkNVLXJl
Z2lzdGVyZWQgdGhyZWFkLg0KDQpTaWduZWQtb2ZmLWJ5OiBLZWlyIEZyYXNlciA8a2VpckBjb2hv
ZGF0YS5jb20+DQotLS0NCiB1cmN1LWNhbGwtcmN1LWltcGwuaCB8IDMgKysrDQogMSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvdXJjdS1jYWxsLXJjdS1pbXBs
LmggYi91cmN1LWNhbGwtcmN1LWltcGwuaA0KaW5kZXggMTBjNGYzZS4uYTA1MGQ0MSAxMDA2NDQN
Ci0tLSBhL3VyY3UtY2FsbC1yY3UtaW1wbC5oDQorKysgYi91cmN1LWNhbGwtcmN1LWltcGwuaA0K
QEAgLTg4Nyw2ICs4ODcsOSBAQCB2b2lkIGNhbGxfcmN1X2FmdGVyX2ZvcmtfY2hpbGQodm9pZCkN
CiAJLyogUmVsZWFzZSB0aGUgbXV0ZXguICovDQogCWNhbGxfcmN1X3VubG9jaygmY2FsbF9yY3Vf
bXV0ZXgpOw0KIA0KKwkvKiBObyBSQ1UtcmVnaXN0ZXJlZCB0aHJlYWRzIGF0IHRoaXMgcG9pbnQu
IENsZWFuIHRoZSByZWdpc3RyeS4gKi8NCisJQ0RTX0lOSVRfTElTVF9IRUFEKCZyZWdpc3RyeSk7
DQorDQogCS8qIERvIG5vdGhpbmcgd2hlbiBjYWxsX3JjdSgpIGhhcyBub3QgYmVlbiB1c2VkICov
DQogCWlmIChjZHNfbGlzdF9lbXB0eSgmY2FsbF9yY3VfZGF0YV9saXN0KSkNCiAJCXJldHVybjsN
Ci0tIA0KMS44LjMuMg0KDQo=
------=_Part_3382_1897829317.1397737200896
Content-Type: text/x-patch; name=2-clear-paused-flag.patch
Content-Disposition: attachment; filename=2-clear-paused-flag.patch
Content-Transfer-Encoding: base64

PkZyb20gNzcyMjk1MmQxODExMzI4NTZkNzFjOTI5ZjUzOTVlNjJhMDVmNWMwYyBNb24gU2VwIDE3
IDAwOjAwOjAwIDIwMDENCkZyb206IEtlaXIgPGtlaXJAY29ob2RhdGEuY29tPg0KRGF0ZTogTW9u
LCA3IEFwciAyMDE0IDE0OjI4OjUyICswMTAwDQpTdWJqZWN0OiBbUEFUQ0ggMi8yXSBjYWxsX3Jj
dSB0aHJlYWRzIHNob3VsZCBjbGVhciB0aGVpciBQQVVTRUQgZmxhZw0KIHdoZW4gdGhleSB1bnBh
dXNlLg0KDQpBbmQgY2FsbF9yY3VfYWZ0ZXJfZm9ya19wYXJlbnQgc2hvdWxkIHNwaW4td2FpdCBv
biB0aGlzLg0KDQpPdGhlcndpc2UgYSBzZWNvbmQgZm9yayBpbiB0aGUgcGFyZW50IHdpbGwgc2Vl
IHRoZSBQQVVTRUQgZmxhZ3MNCmFscmVhZHkgc2V0IGFuZCBjYWxsX3JjdV9iZWZvcmVfZm9yayB3
aWxsIG5vdCBjb3JyZWN0bHkgd2FpdCBmb3IgdGhlDQpjYWxsX3JjdSB0aHJlYWRzIHRvIHF1aWVz
Y2Ugb24gdGhpcyBzZWNvbmQgb2NjYXNpb24uDQoNClNpZ25lZC1vZmYtYnk6IEtlaXIgRnJhc2Vy
IDxrZWlyQGNvaG9kYXRhLmNvbT4NCi0tLQ0KIHVyY3UtY2FsbC1yY3UtaW1wbC5oIHwgNiArKysr
KysNCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS91cmN1
LWNhbGwtcmN1LWltcGwuaCBiL3VyY3UtY2FsbC1yY3UtaW1wbC5oDQppbmRleCBhMDUwZDQxLi41
YzI1YTc1IDEwMDY0NA0KLS0tIGEvdXJjdS1jYWxsLXJjdS1pbXBsLmgNCisrKyBiL3VyY3UtY2Fs
bC1yY3UtaW1wbC5oDQpAQCAtMzA4LDYgKzMwOCw4IEBAIHN0YXRpYyB2b2lkICpjYWxsX3JjdV90
aHJlYWQodm9pZCAqYXJnKQ0KIAkJCXVhdG9taWNfb3IoJmNyZHAtPmZsYWdzLCBVUkNVX0NBTExf
UkNVX1BBVVNFRCk7DQogCQkJd2hpbGUgKCh1YXRvbWljX3JlYWQoJmNyZHAtPmZsYWdzKSAmIFVS
Q1VfQ0FMTF9SQ1VfUEFVU0UpICE9IDApDQogCQkJCXBvbGwoTlVMTCwgMCwgMSk7DQorCQkJdWF0
b21pY19hbmQoJmNyZHAtPmZsYWdzLCB+VVJDVV9DQUxMX1JDVV9QQVVTRUQpOw0KKwkJCWNtbV9z
bXBfbWJfX2FmdGVyX3VhdG9taWNfYW5kKCk7DQogCQkJcmN1X3JlZ2lzdGVyX3RocmVhZCgpOw0K
IAkJfQ0KIA0KQEAgLTg3Miw2ICs4NzQsMTAgQEAgdm9pZCBjYWxsX3JjdV9hZnRlcl9mb3JrX3Bh
cmVudCh2b2lkKQ0KIA0KIAljZHNfbGlzdF9mb3JfZWFjaF9lbnRyeShjcmRwLCAmY2FsbF9yY3Vf
ZGF0YV9saXN0LCBsaXN0KQ0KIAkJdWF0b21pY19hbmQoJmNyZHAtPmZsYWdzLCB+VVJDVV9DQUxM
X1JDVV9QQVVTRSk7DQorCWNkc19saXN0X2Zvcl9lYWNoX2VudHJ5KGNyZHAsICZjYWxsX3JjdV9k
YXRhX2xpc3QsIGxpc3QpIHsNCisJCXdoaWxlICgodWF0b21pY19yZWFkKCZjcmRwLT5mbGFncykg
JiBVUkNVX0NBTExfUkNVX1BBVVNFRCkgIT0gMCkNCisJCQlwb2xsKE5VTEwsIDAsIDEpOw0KKwl9
DQogCWNhbGxfcmN1X3VubG9jaygmY2FsbF9yY3VfbXV0ZXgpOw0KIH0NCiANCi0tIA0KMS44LjMu
Mg0KDQo=
------=_Part_3382_1897829317.1397737200896
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

------=_Part_3382_1897829317.1397737200896--
