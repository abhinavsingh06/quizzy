import React from 'react';
import * as Routes from '../../utils/Routes';
import { fetchApi } from '../../utils/API';
import List from '../questions/List';

class Show extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      setPublish: false,
      slug: this.props.quiz.slug,
    };
  }

  publishQuiz = () => {
    fetchApi({
      url: Routes.quizzes_publish_path(this.props.quiz.id),
      method: 'PUT',
      body: {
        setPublish: true,
        slug: this.state.slug,
      },
      onError: response => {
        console.log(response);
      },
      onSuccess: response => {
        console.log(response);
      },
      successCallBack: () => {
        window.location.href = Routes.show_quiz_path(this.props.quiz.id);
      },
    });
  };

  handlePublish = () => {
    return this.props.quiz.slug ? (
      <button type="button" className="btn btn-success mr-1">
        <a
          style={{ color: 'white' }}
          href={Routes.new_attempt_path(this.state.slug)}>
          Published
        </a>
      </button>
    ) : (
      <button type="button" className="btn btn-primary mr-1">
        <a style={{ color: 'white' }} onClick={() => this.publishQuiz()}>
          Publish
        </a>
      </button>
    );
  };

  render() {
    return (
      <>
        <div className="card text-white bg-dark">
          <div className="card-body">
            <div className="d-flex justify-content-between">
              <h2>{this.props.quiz.name}</h2>
              <div>
                {this.props.questions.length ? this.handlePublish() : ''}
                <button type="button" className="btn btn-primary">
                  <a
                    href={Routes.new_quiz_question_path(this.props.quiz.id)}
                    style={{ color: 'white' }}>
                    Add questions
                  </a>
                </button>
              </div>
            </div>
          </div>
        </div>
        {this.props.quiz.slug ? (
          <div className="alert alert-dark mt-3" role="alert">
            This quiz is published here{' '}
            <a href={Routes.new_attempt_path(this.props.quiz.slug)}>
              {window.location.origin +
                Routes.new_attempt_path(this.props.quiz.slug)}
            </a>
          </div>
        ) : (
          ''
        )}
        {this.props.questions.length ? (
          <List questions={this.props.questions} quiz={this.props.quiz} />
        ) : (
          <h3 className="text-center m-3">
            No questions are present at the moment!
          </h3>
        )}
      </>
    );
  }
}

export default Show;
