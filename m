From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: -warn-common with lttng-ust 2.0.2
Date: Fri, 8 Jun 2012 13:17:28 -0400
Message-ID: <20120608171728.GA22579__26916.9277781204$1339175877$gmane$org@Krystal>
References: <4FD11C7E.7060303@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Sd2oU-0002Lh-Ml
	for lttng-dev@lists.lttng.org; Fri, 08 Jun 2012 13:17:30 -0400
Content-Disposition: inline
In-Reply-To: <4FD11C7E.7060303@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Hollis Blanchard <hollis_blanchard@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Hollis Blanchard (hollis_blanchard@mentor.com) wrote:
> Hi, I was adding an LTTng UST 2.0 tracepoint to an application that uses  
> -warn-common (see http://www.math.utah.edu/docs/info/ld_2.html). I  
> created a simple tracepoint, had lttng-gen-tp produce tracepoints.o,  
> then linked that to the application, along with -llttng-ust. This  
> results in some warnings:
>
> tracepoints.o: warning: common of `handle' overridden by definition
> /usr/local/lib/liblttng-ust.so: warning: defined here
> tracepoints.o: warning: common of `lttng_client_callbacks_overwrite' overridden by definition
> /usr/local/lib/liblttng-ust.so: warning: defined here
> tracepoints.o: warning: common of `lttng_client_callbacks_discard' overridden by definition
> /usr/local/lib/liblttng-ust.so: warning: defined here
> tracepoints.o: warning: common of `lttng_client_callbacks_metadata' overridden by definition
> /usr/local/lib/liblttng-ust.so: warning: defined here
> /usr/local/lib/liblttng-ust-tracepoint.so.0: warning: multiple common of `handle'
> tracepoints.o: warning: previous common is here
>
> This seems to be a valid warning. The LTTng UST headers contain  
> definitions like this in include/lttng/ringbuffer-config.h:
> struct lttng_ust_shm_handle *handle;
>
> If two objects use that header, each will get a copy of "handle", right?

Thanks for reporting, fixed by master commit:


commit 5a821cd6258af4b44aac352bd89b715377cee7d2
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Fri Jun 8 13:17:05 2012 -0400

    Fix: don't define variables in headers
    
    From Hollis Blanchard <hollis_blanchard@mentor.com>:
    > Hi, I was adding an LTTng UST 2.0 tracepoint to an application that uses
    > -warn-common (see http://www.math.utah.edu/docs/info/ld_2.html). I created
    > a simple tracepoint, had lttng-gen-tp produce tracepoints.o, then linked
    > that to the application, along with -llttng-ust. This results in some
    > warnings:
    >
    > tracepoints.o: warning: common of `handle' overridden by definition
    > /usr/local/lib/liblttng-ust.so: warning: defined here
    > tracepoints.o: warning: common of `lttng_client_callbacks_overwrite' overridden
    > +by definition
    > /usr/local/lib/liblttng-ust.so: warning: defined here
    > tracepoints.o: warning: common of `lttng_client_callbacks_discard' overridden by
    > +definition
    > /usr/local/lib/liblttng-ust.so: warning: defined here
    > tracepoints.o: warning: common of `lttng_client_callbacks_metadata' overridden
    > +by definition
    > /usr/local/lib/liblttng-ust.so: warning: defined here
    > /usr/local/lib/liblttng-ust-tracepoint.so.0: warning: multiple common of
    > +`handle'
    > tracepoints.o: warning: previous common is here
    >
    > This seems to be a valid warning. The LTTng UST headers contain
    > definitions like this in include/lttng/ringbuffer-config.h:
    > struct lttng_ust_shm_handle *handle;
    >
    > If two objects use that header, each will get a copy of "handle", right?
    
    handle: This was meant to be a forward declaration of
    
      struct lttng_ust_shm_handle
    
    so just removing the "*handle" part. This can be considered as a
    cleanup (or a fix without actual runtime effect).
    
    lttng_client_callbacks_*: if the cb values would have been used in the
    consumer daemon, this would have caused an issue: these would be set to
    NULL instead of the actual callback pointers. So in a way this is a fix,
    but it does not have any runtime impact at this point.
    
    Reported-by: Hollis Blanchard <hollis_blanchard@mentor.com>
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>



-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
