From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: UST segfault: memcpy too big
Date: Tue, 9 Oct 2012 12:52:38 -0400
Message-ID: <20121009165238.GA5195__3442.12410641394$1349801596$gmane$org@Krystal>
References: <50735E53.1010104@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TLd2t-0001YY-9B
	for lttng-dev@lists.lttng.org; Tue, 09 Oct 2012 12:52:39 -0400
Content-Disposition: inline
In-Reply-To: <50735E53.1010104@mentor.com>
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
> I seem to have hit a little problem with a "hello world" test app and  
> lttng-ust 2.0.3. lttng-ust.git seems to be affected as well. Basically,  
> I created a single UST tracepoint, but as soon as I run "lttng  
> enable-event -u -a", my app segfaults. The problem seems to be that when  
> creating the event to pass to ltt_event_create(), we try to memcpy the  
> full 256 bytes of name. However, the name might be shorter, and if we  
> get unlucky it falls within 256 bytes of the segment boundary...

Good catch !!

Fixed by commit:

master:

commit 1c7b4a9b7cc83f750a7d58d5e2f4894a2559f583
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Tue Oct 9 12:47:31 2012 -0400

    Fix: memcpy of string is larger than source
    
    Hollis Blanchard <hollis_blanchard@mentor.com> wrote:
    > I seem to have hit a little problem with a "hello world" test app and
    > lttng-ust 2.0.3. lttng-ust.git seems to be affected as well. Basically,
    > I created a single UST tracepoint, but as soon as I run "lttng
    > enable-event -u -a", my app segfaults. The problem seems to be that when
    > creating the event to pass to ltt_event_create(), we try to memcpy the
    > full 256 bytes of name. However, the name might be shorter, and if we
    > get unlucky it falls within 256 bytes of the segment boundary...
    
    Fixing the 3 sites where this issue arise. Manually inspecting all
    memcpy in the UST code returned by grep did the job.
    
    Reported-by: Hollis Blanchard <hollis_blanchard@mentor.com>
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

stable-2.0:

commit 7a673d9947d11a37d08be89a5c157afdfd377f9f
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Tue Oct 9 12:47:31 2012 -0400

    Fix: memcpy of string is larger than source
    
    Hollis Blanchard <hollis_blanchard@mentor.com> wrote:
    > I seem to have hit a little problem with a "hello world" test app and
    > lttng-ust 2.0.3. lttng-ust.git seems to be affected as well. Basically,
    > I created a single UST tracepoint, but as soon as I run "lttng
    > enable-event -u -a", my app segfaults. The problem seems to be that when
    > creating the event to pass to ltt_event_create(), we try to memcpy the
    > full 256 bytes of name. However, the name might be shorter, and if we
    > get unlucky it falls within 256 bytes of the segment boundary...
    
    Fixing the 3 sites where this issue arise. Manually inspecting all
    memcpy in the UST code returned by grep did the job.
    
    Reported-by: Hollis Blanchard <hollis_blanchard@mentor.com>
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks!

Mathieu

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
