From: Nathan Lynch <Nathan_Lynch@mentor.com>
Subject: Re: [PATCH] use AC_CHECK_TOOL for objcopy and strip
Date: Mon, 14 Dec 2015 12:56:39 -0600
Message-ID: <566F10E7.1040108__26308.6713421673$1450119465$gmane$org@mentor.com>
References: <1449852204-11379-1-git-send-email-nathan_lynch@mentor.com>
 <566AFDB5.8000103@mentor.com> <566EF478.5000403@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Nathan_Lynch@mentor.com>) id 1a8YIi-00077V-8f
 for lttng-dev@lists.lttng.org; Mon, 14 Dec 2015 13:56:49 -0500
In-Reply-To: <566EF478.5000403@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 12/14/2015 10:55 AM, Jonathan Rajotte Julien wrote:
> Hi Nathan,
> 
> Michael Jeanson already posted a patch [1] regarding this. His patch
> seems more complete since it also reuse objcopy for stripping instead of
> strip.
> 
> Could you test the patch?
> 
> Cheers
> 
> [1] https://lists.lttng.org/pipermail/lttng-dev/2015-December/025332.html

That patch works too, thanks.
