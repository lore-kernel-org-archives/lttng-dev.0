From: Zifei Tong <zifeitong@gmail.com>
Subject: Re: userspace-rcu-0.8.6 problems on MacOSX
Date: Fri, 13 Mar 2015 17:05:25 +0800
Message-ID: <CAJ7wx-FMimiOxdDp0jbvXjzHmE-FB_q3k5fqwJmoim+Srw8Jxg__23962.5622438782$1426237617$gmane$org@mail.gmail.com>
References: <18312E03-EE49-4807-8227-7DE555AFFD28@rfc1035.com>
 <5501CBE5.1020702@voxpopuli.im>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <soariez@gmail.com>) id 1YWLXm-0000lR-Nc
 for lttng-dev@lists.lttng.org; Fri, 13 Mar 2015 05:06:11 -0400
Received: by obbnt9 with SMTP id nt9so18373751obb.12
 for <lttng-dev@lists.lttng.org>; Fri, 13 Mar 2015 02:06:05 -0700 (PDT)
In-Reply-To: <5501CBE5.1020702@voxpopuli.im>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Cc: Jim Reid <jim@rfc1035.com>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

I tried building urcu on my Yosemite laptop.

On Fri, Mar 13, 2015 at 1:24 AM, Alexandre Montplaisir
<alexmonthy@voxpopuli.im> wrote:
> Hi,
>
> Technically, liburcu is not supported on Mac, but if we can easily make it
> work, why not try!
>
> I tried compiling it on an OS X system (Yosemite, autoconf/automake
> installed from Homebrew), but got many errors like this one:
>
> In file included from wfcqueue.c:26:
>
> ./urcu/static/wfcqueue.h:260:22: error: passing 'struct __cds_wfcq_head *'
> to parameter of incompatible type 'cds_wfcq_head_ptr_t'
>
>         if (_cds_wfcq_empty(head, tail))
>
>                             ^~~~
>
> ./urcu/static/wfcqueue.h:132:56: note: passing argument to parameter
> 'u_head' here
>
> static inline bool _cds_wfcq_empty(cds_wfcq_head_ptr_t u_head,
>
>                                                        ^
>
> What steps did you use to make it compile?

gcc 4.9 from Homebrew works fine. For clang I have to apply a patch to move
'__attribute__((__transparent_union__))' after the union declaration.
I think this
might be a clang bug.

diff --git a/urcu/lfstack.h b/urcu/lfstack.h
index cd8e958..fa58054 100644
--- a/urcu/lfstack.h
+++ b/urcu/lfstack.h
@@ -84,10 +84,10 @@ struct cds_lfs_stack {
  * struct cds_lfs_stack and struct __cds_lfs_stack on any of those two
  * types.
  */
-typedef union __attribute__((__transparent_union__)) {
+typedef union {
  struct __cds_lfs_stack *_s;
  struct cds_lfs_stack *s;
-} cds_lfs_stack_ptr_t;
+} __attribute__((__transparent_union__)) cds_lfs_stack_ptr_t;

 #ifdef _LGPL_SOURCE

diff --git a/urcu/wfcqueue.h b/urcu/wfcqueue.h
index df26e33..9d78d1b 100644
--- a/urcu/wfcqueue.h
+++ b/urcu/wfcqueue.h
@@ -79,10 +79,10 @@ struct cds_wfcq_head {
  * struct cds_wfcq_head and struct __cds_wfcq_head on any of those two
  * types.
  */
-typedef union __attribute__((__transparent_union__)) {
+typedef union {
  struct __cds_wfcq_head *_h;
  struct cds_wfcq_head *h;
-} cds_wfcq_head_ptr_t;
+} __attribute__((__transparent_union__))  cds_wfcq_head_ptr_t;

 struct cds_wfcq_tail {
  struct cds_wfcq_node *p;
diff --git a/urcu/wfstack.h b/urcu/wfstack.h
index 362cacc..3ac3be4 100644
--- a/urcu/wfstack.h
+++ b/urcu/wfstack.h
@@ -97,10 +97,10 @@ struct cds_wfs_stack {
  * struct cds_wfs_stack and struct __cds_wfs_stack on any of those two
  * types.
  */
-typedef union __attribute__((__transparent_union__)) {
+typedef union {
  struct __cds_wfs_stack *_s;
  struct cds_wfs_stack *s;
-} cds_wfs_stack_ptr_t;
+} __attribute__((__transparent_union__))  cds_wfs_stack_ptr_t;

 #ifdef _LGPL_SOURCE

> Cheers,
> Alexandre
>
>
>
> On 2015-03-11 11:50 AM, Jim Reid wrote:
>>
>> Hi. There are some problems getting this to compile on MacOSX (10.9.5):
>>
>> 1) Many of the make regtest tests fail because the time command use
>> command line arguments. eg:
>>
>> ...
>> ./test_urcu_lgc 4 4 10 -d 2 -b 32768
>> /usr/bin/time: illegal option -- a
>> usage: time [-lp] command.
>> ...
>>
>> 2) The generated Makefiles feed Linuxy linker arguments (-Wl,-rpath==) to
>> the compiler.
>> I kludged that by manually editing the Makefile(s) to just use -L././libs
>> instead. Which would seem to be a better solution in general. YMMV.

Apparently, ld in OS X does not support -Wl,-rpath="/foo/bar" syntax,
simply replace '='
with space like -Wl,-rpath "/foo/bar" did the trick. I can send a
patch for this.

Thanks,
Zifei Tong

>> Could you please fix these for a future release? Thanks.
>>
>>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
