From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [lttng-dev] [PATCH] trace: drop LTTng Userspace
	Tracer backend
Date: Thu, 26 Sep 2013 10:01:21 +0200
Message-ID: <20130926080121.GD24531@stefanha-thinkpad.redhat.com>
References: <1380101319-29435-1-git-send-email-stefanha@redhat.com>
	<52431092.7040109@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
Content-Disposition: inline
In-Reply-To: <52431092.7040109@polymtl.ca>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: Mohamad Gebai <mohamad.gebai@polymtl.ca>
Cc: lttng-dev@lists.lttng.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
List-Id: lttng-dev@lists.lttng.org

On Wed, Sep 25, 2013 at 12:34:26PM -0400, Mohamad Gebai wrote:
> I am actually using LTTng 2.x as a backend for UST to do some
> performance analysis and latency investigation using Qemu/KVM. I
> already have all the patches ready to replace the old 0.x interface,
> and I am preparing them for the merge upstream.

Excellent, I was hoping to find someone who wants to update the code.

Do you need the old 0.x code for your patches or is it cleaner if we
apply my patch to drop that first?  I guess you pretty much rewrote
the ./configure and tracetool pieces...

Stefan
