From: Zifei Tong <zifeitong@gmail.com>
Subject: Re: LTTng c++ loglevel not being set
Date: Thu, 25 Jun 2015 13:55:13 +0800
Message-ID: <CAJ7wx-F5tr_YiJ1z+tyeJP3Kn4Lk+Y9OvFvXSiLsRzchuBMRAg__35180.0770069987$1435211807$gmane$org@mail.gmail.com>
References: <BLU169-W5812986F014E6A9F9F766AABAE0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yh0-f45.google.com ([209.85.213.45])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <soariez@gmail.com>) id 1Z808k-0000pF-9U
 for lttng-dev@lists.lttng.org; Thu, 25 Jun 2015 01:55:59 -0400
Received: by yhjh26 with SMTP id h26so3003352yhj.3
 for <lttng-dev@lists.lttng.org>; Wed, 24 Jun 2015 22:55:52 -0700 (PDT)
In-Reply-To: <BLU169-W5812986F014E6A9F9F766AABAE0@phx.gbl>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jeffrey Chen <cpthk@hotmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

I can confirm this issue (w/ lttng master HEAD + gcc 5.1).

In include/lttng/ust-tracepoint-event.h, we have
#define TRACEPOINT_EVENT_INSTANCE(_provider, _template, _name, _args)          \
static const int *                                                             \
        __ref_loglevel___##_provider##___##_name                               \
        __attribute__((weakref ("_loglevel___" #_provider "___" #_name)));     \
static const char *                                                            \
        __ref_model_emf_uri___##_provider##___##_name                          \
        __attribute__((weakref ("_model_emf_uri___" #_provider "___" #_name)));\

I think the weakref attributes used here should use mangled symbol
name when compiling with C++.

A workaround is attached. However, I don't know how to disable symbol
mangling for a static variable, therefore the 'static' attribute is
dropped. I am not sure whether exporting the symbol will cause other
issues.

diff --git a/include/lttng/ust-tracepoint-event.h
b/include/lttng/ust-tracepoint-event.h
index 6632f67..7356451 100644
--- a/include/lttng/ust-tracepoint-event.h
+++ b/include/lttng/ust-tracepoint-event.h
@@ -676,9 +676,14 @@ const char
__tp_event_signature___##_provider##___##_name[] =              \
 #include <lttng/ust-tracepoint-event-reset.h>

 #undef TRACEPOINT_LOGLEVEL
+
+#ifdef __cplusplus
+#define DISABLE_MANGLING extern "C"
+#endif
+
 #define TRACEPOINT_LOGLEVEL(__provider, __name, __loglevel)               \
 static const int _loglevel_value___##__provider##___##__name = __loglevel; \
-static const int *_loglevel___##__provider##___##__name =                 \
+DISABLE_MANGLING const int *_loglevel___##__provider##___##__name =
            \
                &_loglevel_value___##__provider##___##__name;

 #include TRACEPOINT_INCLUDE

Thanks,
Zifei

On Thu, Jun 25, 2015 at 9:42 AM, Jeffrey Chen <cpthk@hotmail.com> wrote:
>
> I noticed a macro issue with LTTng under C++. The TRACEPOINT_LOGLEVEL would be ignored.
>
> Here are my steps to repro the issue. My .tp file has the TRACEPOINT_LOGLEVEL macro set.
> 1. I generated the hello-tp.c file from the hello-tp.tp file using the lttng-gen-tp tool.
> 2. I renamed the generated .c file into .cpp and compiled with `g++ -c -I. hello-tp.cpp`
> 3. I wrote my c++ code called and call tracepoint macro, saved to hello.cpp, compiled with `g++ -c -I. hello.cpp`
> 4. I compile to an executable with `g++ -o hello hello.o hello-tp.o -llttng-ust -ldl`
> 5. I run the executable, and noticed the loglevel I set in the .tp file is not working. All the traces are still being written as default loglevel TRACE_DEBUG_LINE.
>
> I tried confirming it by using `lttng list --userspace` command and I see "hello_world:my_first_tracepoint (loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoint)"
> You could see the loglevel was not set.
>
> I tried the same steps without renaming to cpp files and build with `gcc` command and it works fine. I also tried without renaming to cpp files but compiled with `g++` command, but it also does not work. It seems to have something to do with c++ name mangling. Anyone noticed this issue? Thanks.
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
