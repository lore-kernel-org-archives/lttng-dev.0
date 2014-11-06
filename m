From: Suchakrapani Datt Sharma <suchakrapani.sharma@polymtl.ca>
Subject: Location of session.xsd file in rpm
Date: Thu, 06 Nov 2014 01:36:50 +0000
Message-ID: <20141106013650.Horde.NnfxpCaJN2ZhcO7cvOOLEg1__33619.6989905604$1415237822$gmane$org@www.imp.polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="Yes"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <suchakrapani.sharma@polymtl.ca>) id 1XmBzv-0000wy-73
 for lttng-dev@lists.lttng.org; Wed, 05 Nov 2014 20:36:28 -0500
Received: from horde5.polymtl.ca (horde5.polymtl.ca [132.207.4.156])
 by smtp.polymtl.ca (8.14.3/8.14.3) with ESMTP id sA61aQ4k020219
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Wed, 5 Nov 2014 20:36:26 -0500
Content-Disposition: inline
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

Hi,

While packaging lttng-tools 2.5.1 for Fedora, I observed that the  
following file is installed by default :
/usr/share/xml/lttng/session.xsd

I want to know if its required to be included in the package and if  
yes, is it ok to install it in /usr/share/lttng/xml.

Thanks,
Suchakra
