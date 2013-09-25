From: Mohamad Gebai <mohamad.gebai@polymtl.ca>
Subject: Re: [PATCH] trace: drop LTTng Userspace Tracer backend
Date: Wed, 25 Sep 2013 12:34:26 -0400
Message-ID: <52431092.7040109__27052.7328168557$1380126936$gmane$org@polymtl.ca>
References: <1380101319-29435-1-git-send-email-stefanha@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <mohamad.gebai@polymtl.ca>) id 1VOs2s-0005kp-GB
	for lttng-dev@lists.lttng.org; Wed, 25 Sep 2013 12:34:39 -0400
In-Reply-To: <1380101319-29435-1-git-send-email-stefanha@redhat.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: lttng-dev@lists.lttng.org, =?UTF-8?B?QWxleCBCZQ==?= =?UTF-8?B?bm7DqWU=?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, =?UTF-8?B?TGx1w61zIFZpbGFu?= =?UTF-8?B?b3Zh?= <vilanova@ac.upc.edu>
List-Id: lttng-dev@lists.lttng.org

Hi Stefan,

I am actually using LTTng 2.x as a backend for UST to do some 
performance analysis and latency investigation using Qemu/KVM. I already 
have all the patches ready to replace the old 0.x interface, and I am 
preparing them for the merge upstream.
