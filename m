From: "Liu, Changcheng via lttng-dev" <lttng-dev@lists.lttng.org>
Subject: convert call_site to func/offset
Date: Wed, 1 Jul 2020 23:53:09 +0800
Message-ID: <20200701155309.GA99920@jerryopenix>
Reply-To: "Liu, Changcheng" <changcheng.liu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by lists.lttng.org (Postfix) with ESMTPS id 49xm8w5G3gz18yY
 for <lttng-dev@lists.lttng.org>; Wed,  1 Jul 2020 11:58:08 -0400 (EDT)
Content-Disposition: inline
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi all,
    I checked __cyg_profile_func_enter implementation.
    The caller address is recorded into call_site field.

    Does anyone know how to let babeltrace show the call_site into
    "func/offset" format instead of the running virtual address?
    
B.R.
Changcheng
