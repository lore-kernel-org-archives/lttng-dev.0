From: =?ISO-8859-1?Q?Marc-Andr=E9_Laperle?= <marc-andre.laperle@ericsson.com>
Subject: Re: Progress on base address outstanding issues
Date: Tue, 20 May 2014 16:57:06 -0400
Message-ID: <537BC1A2.6020409__28337.0876023129$1400619499$gmane$org@ericsson.com>
References: <66971283.20283.1400614378328.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg21.ericsson.net ([198.24.6.65])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <marc-andre.laperle@ericsson.com>) id 1Wmr62-00042U-9i
 for lttng-dev@lists.lttng.org; Tue, 20 May 2014 16:57:20 -0400
In-Reply-To: <66971283.20283.1400614378328.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Mathieu,

I actually just started to use this feature in TMF so that we can handle
libraries properly when showing call stacks (cygprofile). Hopefully this
won't be removed :) Maybe I could look into the issue in a few weeks but
it's likely that someone with better knowledge of LTTng's internals
would come up with a fix much faster.

Regards,
Marc-Andre

On 14-05-20 03:32 PM, Mathieu Desnoyers wrote:
> Hi,
>
> We are currently revisiting the open issues before the
> 2.5 release cycle, and we are wondering if there has been
> any progress on bug http://bugs.lttng.org/issues/745 ?
>
> This feature is currently "experimental", but buggy
> (triggers deadlocks). Until we have a fix for this, it will
> stay experimental, and if there is no further progress on
> this front, we will mark it for removal for the 2.6 release
> cycle (around August 2014).
>
> Thank you,
>
> Mathieu
>
