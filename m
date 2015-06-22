From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: LTTng event loglevel
Date: Mon, 22 Jun 2015 17:20:35 -0400
Message-ID: <55887C23.8010306__44223.8181982704$1435008124$gmane$org@voxpopuli.im>
References: <BLU169-W114739E6F78BF869CAD7B8ABA10@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexmonthy@voxpopuli.im>) id 1Z7996-0000oZ-2O
 for lttng-dev@lists.lttng.org; Mon, 22 Jun 2015 17:20:56 -0400
In-Reply-To: <BLU169-W114739E6F78BF869CAD7B8ABA10@phx.gbl>
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

On 2015-06-22 05:06 PM, Jeffrey Chen wrote:
> Hi:
>
> I am reading the LTTng and I am confused about the loglevel in the document. The document talked about it could assign a loglevel to each event. (http://lttng.org/docs/#doc-assigning-log-levels)

This part refers to when you define your own tracepoints in your pogram, 
using the TRACEPOINT_EVENT macro.

>   But, later in the document, it says all events from LTTng are traced as loglevel TRACE_DEBUG_FUNCTION. (http://lttng.org/docs/#doc-liblttng%E2%80%91ust%E2%80%91cyg%E2%80%91profile)

That part however, refers to using the liblttng-ust-cyg-profile library, 
to automatically instrument function entries and exits. This library 
implements the callbacks expected by cyg-profile, and puts the 
information into UST tracepoints. Since it's this 
liblttng-ust-cyg-profile library that "defines" the tracepoints here, 
they are stuck at the log level specified in their definition, which is 
TRACE_DEBUG_FUNCTION in this case.


Hope this helps,
Alexandre
