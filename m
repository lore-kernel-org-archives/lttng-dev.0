From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: Re: [PATCH babeltrace] Fix running tests out of tree
Date: Fri, 20 Feb 2015 10:55:24 -0500
Message-ID: <1424447725-8813-1-git-send-email-jonathan.rajotte-julien__3657.02525382421$1424447867$gmane$org@efficios.com>
References: <CAFXXi0nY4x+bsv9=d2e6CgpNxB-MQQJ+BNNbA=W2-c1J0pXJ2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1YOpvg-0002O0-Dw
 for lttng-dev@lists.lttng.org; Fri, 20 Feb 2015 10:55:54 -0500
In-Reply-To: <CAFXXi0nY4x+bsv9=d2e6CgpNxB-MQQJ+BNNbA=W2-c1J0pXJ2Q@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: thundersim@gmail.comi
List-Id: lttng-dev@lists.lttng.org

Took Simon's patch and made some modifications to it. Mostly making sure we
delete copied static files on make clean.

See: Fix: test: add automake variable for test trace folders copy on oot build

Cheers!
