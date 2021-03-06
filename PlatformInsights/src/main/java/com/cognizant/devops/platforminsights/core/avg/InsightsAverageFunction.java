/*******************************************************************************
 * Copyright 2017 Cognizant Technology Solutions
 * 
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License.  You may obtain a copy
 * of the License at
 * 
 *   http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
 * License for the specific language governing permissions and limitations under
 * the License.
 ******************************************************************************/
package com.cognizant.devops.platforminsights.core.avg;

import java.io.Serializable;

import org.apache.spark.api.java.function.PairFunction;

import scala.Tuple2;

/**
 * This averages the output against a key like project id. Avg time per project id
 * @author 180852
 *
 */
public class InsightsAverageFunction implements PairFunction<Tuple2<String, Tuple2<Long, Integer>>,String,Long>,Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 501293508044055060L;

	@Override
    public Tuple2<String, Long> call(Tuple2<String, Tuple2<Long, Integer>> tuple) {
    	Tuple2<Long, Integer> val = tuple._2;
        Long total = val._1;
        Integer count = val._2;
        Tuple2<String, Long> averagePair = new Tuple2<String, Long>(tuple._1, total / count);
        return averagePair;
    }
}
