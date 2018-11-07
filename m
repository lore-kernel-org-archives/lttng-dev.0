From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: lost trace events
Date: Wed, 7 Nov 2018 15:09:29 -0500
Message-ID: <20181107200929.GA12330__31045.2385493138$1541621259$gmane$org@joraj-alpa>
References: <CADwgpi8TmCUgz4uF8CpPs-1-SooENXvYgA2ZqjXbcMgsSwzRdg@mail.gmail.com>
 <20181107153120.GA15594@joraj-alpa>
 <CADwgpi9Hpm9hYuRi9y9qOVyUvoGWcVkX0ZEm6AvQaPyeN_QWkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 42qyDv2DstzqkH
 for <lttng-dev@lists.lttng.org>; Wed,  7 Nov 2018 15:09:35 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CADwgpi9Hpm9hYuRi9y9qOVyUvoGWcVkX0ZEm6AvQaPyeN_QWkQ@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Alok Priyadarshi <alokpr@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Alok,

On Wed, Nov 07, 2018 at 11:53:25AM -0800, Alok Priyadarshi wrote:
> Hi Jonathan,
> 
> Thanks for your response.
> 
> We are tracing function scopes. Each scope emits two events - begin and
> end. We noticed that some begin events did not have corresponding end
> events in the trace.

Seems like a solid ground as long as the corresponding ending event is not
inside any conditional paths. I'm sure you already validated that but we never
know.

> 
> I have the trace with this problem available. Would that provide any clue?

It could help but I presume it might contains confidential or sensible
information. Let's define the scenario first and we will go back to actual
trace data if needed.

> If not, I will try to extract a small reproducer.

That would be best. In the meantime, could you provide the exact lttng commands
used to setup everything and describe subsequent lttng commands used for
snapshot etc.

You can omit event name or replace them with dummy name if necessary.

Cheers

-- 
Jonathan Rajotte-Julien
EfficiOS
